# Changelog

All notable changes to this project are documented here.

## [0.0.1] - 2026-05-24

Initial public pre-release for validation before a future `1.0.0`.

### Added

- Interactive shell protection for dangerous `rm` usage.
- Blocking for `/` and non-allowed top-level paths such as `/etc`, `/bin`,
  `/usr`, and `/var`.
- Default allowlist for `/tmp` and `/var/tmp`.
- Explicit bypass options with `RM_GUARD=0` and `--no-guard`.
- CLI commands for help, version, status, and update checks.
- Manual install and uninstall scripts.
- Debian package build script.
- Getting started documentation and command reference.

### Changed

- Set the initial release version to `0.0.1`.
- Corrected the MIT license text.

### Notes

- This is a pre-release intended for testing packaging, installation, and
  documentation flow before publishing `1.0.0`.
