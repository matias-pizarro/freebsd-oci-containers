# Bibliography & Community Resources

## Community Resources

- [OCI Containers on FreeBSD](https://freebsdfoundation.org/blog/oci-containers-on-freebsd/) —
  FreeBSD Foundation overview
- [FreeBSD Containers Wiki](https://wiki.freebsd.org/Containers) — community
  wiki tracking container support status (canonical)
- [OCI + ZFS on FreeBSD](https://people.freebsd.org/~dch/posts/2025-06-27-oci-zfs/) —
  Dave Cottlehuber's work on ZFS-backed containers (canonical)
- [SkunkWerks documentation](https://docs.skunkwerks.at/s/fUiAmi4pE) —
  community documentation hub (canonical)
- [Container support matrix](https://docs.google.com/spreadsheets/d/1IGk2uZd2TG3CUddFmWi6_7PygER08n0XlGmronXq0Pk/) —
  tracking spreadsheet for FreeBSD container feature coverage (community-maintained)
- [HackMD notes](https://hackmd.io/xA1CxQT8SfKLUpCiQz-tWA) — community
  collaboration notes (community-maintained)
- [Doug Rabson — OCI on FreeBSD (video)](https://www.youtube.com/watch?v=HV-wUUzRCMo) —
  conference talk on FreeBSD container runtime

## Upstream Forks

Forks of official docker-library projects for developing FreeBSD support patches:

| Project | Upstream | Fork |
|---------|----------|------|
| Node.js | [docker-library/node](https://github.com/nodejs/docker-node) | [matias-pizarro/docker-node](https://github.com/matias-pizarro/docker-node) |
| PostgreSQL | [docker-library/postgres](https://github.com/docker-library/postgres) | [matias-pizarro/docker-postgres](https://github.com/matias-pizarro/docker-postgres) |
| Python | [docker-library/python](https://github.com/docker-library/python) | [matias-pizarro/docker-python](https://github.com/matias-pizarro/docker-python) |

## Related Projects

- [Daemonless](https://daemonless.io/) — Native FreeBSD OCI container images
  using Podman and ocijail; provides a comprehensive image fleet (databases,
  media, infrastructure) and the
  [dbuild](https://daemonless.io/guides/dbuild/)
  ([GitHub](https://github.com/daemonless/dbuild)) build tool for FreeBSD
  container image lifecycle (build, test, publish). dbuild is a Python 3.11+
  CLI available as a FreeBSD port (`sysutils/py-dbuild`). Its pipeline model,
  quality gates, and CLI design informed several decisions in our Phase 3
  design (see `docs/design/phase3-design.md`, section 4).
- [BastilleBSD templates](https://github.com/BastilleBSD/templates) — FreeBSD
  jail templates indicating application demand
- [AppJail](https://github.com/DtxdF/AppJail) — FreeBSD container/jail
  management with application templates
