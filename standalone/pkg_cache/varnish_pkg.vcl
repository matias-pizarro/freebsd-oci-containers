vcl 4.1;

# This configuration uses the workaround described in [1] to validate cache hits using a HTTP HEAD request
# with the cached ETag to work around the "Cache-Control: max-age=0, private" returned by FreeBSD package mirrors.
#
# [1] : https://info.varnish-software.com/blog/systematic-content-validation-with-varnish
#       Archived at: https://web.archive.org/web/20240225012414/https://info.varnish-software.com/blog/systematic-content-validation-with-varnish

import directors;

# Define a backend for each FreeBSD package mirror.
# Use slow health checks to reduce the load on the project infrastructure.
# The backend definitions are sorted by measured bandwidth.

backend bck1 {
	.host = "127.0.0.1";
	.port = "8000";
	.probe = {
		.url       = "/";
		.timeout   = 5s;
		.interval  = 69s;
		.window    = 23;
		.threshold = 5;
	}
}

backend bck2 {
	.host = "127.0.0.1";
	.port = "8001";
	.probe = {
		.url       = "/";
		.timeout   = 5s;
		.interval  = 69s;
		.window    = 23;
		.threshold = 5;
	}
}

backend bck3 {
	.host = "127.0.0.1";
	.port = "8002";
	.probe = {
		.url       = "/";
		.timeout   = 5s;
		.interval  = 69s;
		.window    = 23;
		.threshold = 5;
	}
}

backend bck4 {
	.host = "127.0.0.1";
	.port = "8003";
	.probe = {
		.url       = "/";
		.timeout   = 5s;
		.interval  = 69s;
		.window    = 23;
		.threshold = 5;
	}
}
# Add more servers as needed...

# On load create a fallback type director and populate it
# with the known FreeBSD package mirrors in order of bandwidth
# measured by fastest_pkg (from ports-mgmt/fastest_pkg).
sub vcl_init {
	new pkg = directors.fallback();
	pkg.add_backend(bck1 );
	pkg.add_backend(bck2 );
	pkg.add_backend(bck3 );
	pkg.add_backend(bck4 );
}

# Use restarts to probe the cache validity by ETag.
# Possible states are:
#   - init (req.restarts == 0)
#   - "cache_check"
#   - "backend_check"
#   - "valid"
#
# On misses no re restarts are performed. On hits
# the following state machine runs multiple steps:
#
# ┌────────────────┐
# │                ▼
# │            ┌───────┐
# │     ┌──────┤ recv  ├─────┐
# │     │      └───────┘     │
# │     ▼                    ▼
# │ ┌───────┐            ┌───────┐   ┌──────────────────┐
# │ │ hash  │            │ pass  ├──▶│ backend_fetch    │
# │ └───┬───┘            └───────┘   └─────────┬────────┘
# │     ▼                                      ▼
# │ ┌───────┐  ┌───────┐             ┌──────────────────┐
# ├─┤ hit   │  │ miss  │             │ backend_response │
# │ └───────┘  └───────┘             └─────────┬────────┘
# │                                            │
# │ ┌─────────┐                                │
# └─┤ deliver │◀───────────────────────────────┘
#   └─────────┘
#
# - First start:
#   * Save the Etag.
#   * Restart, because we need to go to the backend.
# - 1st restart:
#   * Pass, because we don't necessarilly want to put the object in cache.
#   * Use a HEAD request to fetch only the headers (including the ETag).
#   * If the backend returns a different ETag evict the conflicting cache entry.
#   * Restart (again).
# - 2nd (and last) restart
#   * Just act normal this time.

# Setup state machine and begin recording the cache hit/miss.
sub vcl_recv {
	# The first time (not yet restarted).
	if (req.restarts == 0) {
		# Use the failover director of FreeBSD package mirrors.
		set req.backend_hint = pkg.backend();

		# Clear the cache hit/miss header.
		unset req.http.X-Cache;

		# Set the internal state to "cache_check".
		set req.http.X-State = "cache_check";
		return (hash);
	# The second time (first restart).
	} else if (req.http.X-State == "backend_check") {
		return (pass);
	# The third (and last) time.
	} else {
		return (hash);
	}
}

# Hash only the URL not the Host/IP address allowing clients to share
# the cache no matter under which Host/IP address they use it.
sub vcl_hash {
	hash_data(req.url);
	return (lookup);
}

# Depending on the X-State...
sub vcl_hit {
	# Extract the ETag from the HEAD reponse.
	if (req.http.X-State == "cache_check") {
		set req.http.X-State = "backend_check";
		set req.http.etag = obj.http.etag;
		return (restart);
	# Record the cache hit
	} else {
		if (obj.ttl <= 0s && obj.grace > 0s) {
			set req.http.X-Cache = "hit graced";
		} else {
			set req.http.X-Cache = "hit";
		}
		return (deliver);
	}
}

# Record the cache miss.
sub vcl_miss {
	set req.http.X-Cache = "miss";
}

# Record the cache pass.
sub vcl_pass {
	set req.http.X-Cache = "pass";
}

# Record pipelined uncachable request.
sub vcl_pipe {
	set req.http.X-Cache = "pipe uncacheable";
}

# Record synthetic responses
sub vcl_synth {
	set req.http.X-Cache = "synth synth";

	# Show the information in the response
	set resp.http.X-Cache = req.http.X-Cache;
}

# Change the HTTP method to HEAD when probing the backend
# FreeBSD package mirrrors for the latest ETag.
sub vcl_backend_fetch {
	if ( bereq.http.X-State == "backend_check" ) {
		set bereq.method = "HEAD";
		set bereq.http.method = "HEAD";
	}
}

# Evict invalidated cache entries.
sub vcl_backend_response {
	# Is the the response to the HTTP HEAD probing request?
	if ( bereq.http.X-State == "backend_check" ) {
		# Evict objects that failed ETag validation.
		if (bereq.http.etag != beresp.http.etag) {
			ban("obj.http.etag == " + bereq.http.etag);
		}
	# Otherwise cache successful responses.
	} else if ( beresp.status == 200 ) {
		# The FreeBSD package mirrors are configured with "Cache-Control: max-age=0, private" which would prevent caching.
		# Set the TTL to 1 second to cache it at all.
		unset beresp.http.cache-control;
		set beresp.ttl = 7d;

		# Keep the response in cache for 7 days if the response has validating headers.
		if (beresp.http.ETag || beresp.http.Last-Modified) {
			set beresp.keep = 7d;
		}
		return(deliver);
	}
}

# Make sure to only deliver real responses.
sub vcl_deliver {
	# The client wants the real response not the response to the probe
	# for the latest ETag so restart (again).
	if (req.http.X-State == "backend_check") {
		set req.http.X-State = "valid";
		return (restart);
	}

	# Append cachability to the X-Cache header.
	if (obj.uncacheable) {
		set req.http.X-Cache = req.http.X-Cache + " uncacheable";
	} else {
		set req.http.X-Cache = req.http.X-Cache + " cached";
	}

	# Show the information in the response
	set resp.http.X-Cache = req.http.X-Cache;
}
