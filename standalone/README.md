# Standalone Container Images

These container images are not part of the main build matrix. They serve
specific use cases and are built independently.

| Image | Description |
|-------|-------------|
| caddy_tls | Caddy web server with automatic TLS via Hetzner DNS |
| pdfium | PDFium PDF rendering library build |
| pkg_cache | FreeBSD package caching proxy |
| podman-api | Podman API proxy via nginx |
