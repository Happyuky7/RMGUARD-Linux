# Changelog

All notable changes to this project are documented here.

## [1.0.0] - 2026-05-24

First stable release.

### Added

- Stable documentation entry points for the website, FAQ, command reference,
  and release notes.
- GitHub Pages static site for RMGuard.
- Additional README translations in Brazilian Portuguese and French.
- Sponsorship and project website links.

### Changed

- Promoted RMGuard from the `0.0.x` pre-release cycle to `1.0.0`.
- Updated install, package, and release commands to use `v1.0.0`.
- Standardized the visible project name as `RMGuard`.

## [0.0.2] - 2026-05-24

Patch pre-release after the first Linux install test.

### Fixed

- Prevented `/etc/profile.d/rmguard.sh` from failing when an existing `rm`
  alias is already loaded before rmguard.
- Fixed `rmguard --status` false negatives by exporting a shell-loaded marker
  from `/etc/profile.d/rmguard.sh`.
- Updated install documentation to use `sudo bash ./scripts/install.sh`, so
  installation works even if shell scripts are cloned without executable mode.

### Changed

- Updated release, package, and documentation defaults to `0.0.2`.
- Added explicit `chmod +x` setup commands for source installs.

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
