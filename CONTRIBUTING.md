# Contributing to FreeBSD OCI Containers

Thank you for your interest in contributing to FreeBSD OCI Containers!
This guide covers the process for reporting issues, submitting patches,
and setting up your development environment.

## Reporting Issues

- Use [GitHub Issues](https://github.com/matias-pizarro/freebsd-oci-containers/issues)
  to report bugs or request features
- Include the FreeBSD version, container runtime version, and image tag
  when reporting bugs
- For security vulnerabilities, please email the maintainer directly
  rather than opening a public issue

## Submitting Patches

1. **Fork** the repository on GitHub
2. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feat/your-feature main
   ```
3. **Make your changes** following the coding conventions below
4. **Write tests** for any new functionality
5. **Run the quality gates** before submitting:
   ```bash
   uv run ruff check .
   uv run ruff format --check .
   uv run pytest tests/ -v
   ```
6. **Submit a pull request** against the `integration` branch

## Development Setup

```bash
# Clone the repository
git clone https://github.com/matias-pizarro/freebsd-oci-containers.git
cd freebsd-oci-containers

# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
uv sync --group dev --group lint --group docs

# Install pre-commit hooks
uv run pre-commit install

# Run tests
uv run pytest tests/ -v

# Run the build system
uv run python build.py
```

## Coding Conventions

The project follows the conventions established in the
[Vision & Design document](docs/design/vision-and-design.md#conventions):

- **Python >=3.11**, managed with **uv**
- **Linting**: ruff with `select = ["ALL"]`, Google-style docstrings
- **Formatting**: ruff format (double quotes, 4-space indent, 88-char lines)
- **Testing**: pytest with pytest-mock, TDD approach
- **Commits**: conventional commit format via commitizen
  (`feat:`, `fix:`, `chore:`, `refactor:`, `test:`, `docs:`, `ci:`)
- **Versioning**: semantic versioning, `v$version` tags
- **Shell scripts**: Always use `"${curly_braces}"` for environment variables

## Branching Strategy

- **Feature branches** (`feat/`, `fix/`, etc.) — all work happens here
- **`integration`** — agent/developer work merges here for validation
- **`main`** — only human-reviewed code from `integration` lands here

## License

By contributing, you agree that your contributions will be licensed
under the [BSD 2-Clause License](LICENSE).
