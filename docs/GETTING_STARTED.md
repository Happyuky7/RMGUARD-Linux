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
chmod +x scripts/*.sh src/rmguard src/rmguard-cli test/rmguard_test.sh
sudo bash ./scripts/install.sh
source /etc/profile
```

## Install From Release Package

Use this only if the `.deb` asset has been uploaded to the release.

```bash
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/download/v0.0.2/rmguard_0.0.2_all.deb
sudo apt install ./rmguard_0.0.2_all.deb
source /etc/profile
```

## Verify

```bash
rmguard --version
rmguard --status
type rm
```

`type rm` may show the friendly alias first. `rmguard --status` should report
that rmguard is active in the current shell.

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

## Build v0.0.2 Package

```bash
bash ./scripts/package.sh 0.0.2
```

The package is created at:

```text
build/rmguard_0.0.2_all.deb
```

## Prepare v0.0.2 Release

```bash
bash ./scripts/release.sh 0.0.2
```

Before publishing, check:

- `rmguard --version` prints `0.0.2`
- `rmguard --status` works after install
- Dangerous top-level paths are blocked
- `/tmp` and `/var/tmp` still work
- `CHANGELOG.md` and `docs/releases/v0.0.2.md` match the release
