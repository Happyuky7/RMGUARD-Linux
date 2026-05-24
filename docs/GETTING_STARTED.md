# Getting Started

This guide covers the quickest path to install, verify, use, and package
rmguard.

## Requirements

- Linux with bash
- `sudo` access for installation
- `coreutils` for `/bin/rm`
- `dpkg-deb` if you want to build a `.deb` package

## Install From Source

```bash
git clone https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux
sudo ./scripts/install.sh
source /etc/profile
```

## Install From Release Package

```bash
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/download/v0.0.1/rmguard_0.0.1_all.deb
sudo apt install ./rmguard_0.0.1_all.deb
source /etc/profile
```

## Verify

```bash
rmguard --version
rmguard --status
type rm
```

`type rm` should show that `rm` is a shell function in the current
interactive shell.

## Try It Safely

```bash
touch /tmp/rmguard-test
rm /tmp/rmguard-test

rm -rf /etc
```

The `/tmp` command should work. The `/etc` command should be blocked.

## Bypass Deliberately

Use a bypass only when you know exactly what you are deleting.

```bash
RM_GUARD=0 rm -rf /path
rm --no-guard -rf /path
```

## Configure Allowed Top-Level Paths

Edit `/etc/rmguard.conf`:

```bash
ALLOW_TOPLEVEL="/tmp /var/tmp"
```

Then open a new shell or run:

```bash
source /etc/profile
```

## Build v0.0.1 Package

```bash
./scripts/package.sh 0.0.1
```

The package is created at:

```text
build/rmguard_0.0.1_all.deb
```

## Prepare v0.0.1 Release

```bash
./scripts/release.sh 0.0.1
```

Before publishing, check:

- `rmguard --version` prints `0.0.1`
- `rmguard --status` works after install
- Dangerous top-level paths are blocked
- `/tmp` and `/var/tmp` still work
- `CHANGELOG.md` and `docs/releases/v0.0.1.md` match the release
