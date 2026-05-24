# RMGuard FAQ

## General

### What is RMGuard?

RMGuard is a shell-level safety guard for interactive Linux sessions. It wraps
the `rm` command with a shell function and blocks dangerous top-level deletion
targets such as `/`, `/etc`, `/bin`, `/usr`, and similar paths.

### Does RMGuard replace `/bin/rm`?

No. RMGuard does not replace `/bin/rm`. It loads an `rm` shell function in
interactive shells and delegates safe commands to `/bin/rm`.

### Is RMGuard a backup tool?

No. RMGuard is only a protection layer for accidental destructive commands. It
does not replace backups, snapshots, permissions, or recovery planning.

## Installation

### Why does the documentation use `sudo bash ./scripts/install.sh`?

It works even if the script was cloned without executable permissions. The docs
also include `chmod +x` so scripts can be executed directly afterward.

### Why does `git clone -b v1.0.0` show detached HEAD?

That is normal when cloning a tag. Release tags are fixed snapshots, not active
branches. For testing a release, detached HEAD is expected.

### Why do I need `source /etc/profile`?

The install script copies the profile hook to `/etc/profile.d/rmguard.sh`.
Running `source /etc/profile` loads it in the current shell. New terminal or SSH
sessions load it automatically.

## Behavior

### Why is `/tmp` allowed by default?

RMGuard allows `/tmp` and `/var/tmp` by default because they are common temporary
work areas. This is configurable in `/etc/rmguard.conf`.

Do not test with `rm -rf /tmp` on a real machine unless you intentionally want
to delete the temporary directory contents. Use a file or directory inside
`/tmp` instead:

```bash
mkdir -p /tmp/rmguard-test
rm -rf /tmp/rmguard-test
```

### Can I make `/tmp` blocked too?

Yes. Edit `/etc/rmguard.conf` and remove `/tmp` from `ALLOW_TOPLEVEL`.

```bash
ALLOW_TOPLEVEL="/var/tmp"
```

Then open a new shell or run:

```bash
source /etc/profile
```

### Why did `rm -rf /tmp` remove `/tmp`?

In the default configuration, `/tmp` is explicitly allowed. If you want stricter
behavior, remove `/tmp` from `ALLOW_TOPLEVEL`.

### Why does `type rm` show an alias?

RMGuard adds a friendly alias with confirmation options. The command
`rmguard --status` is the recommended status check.

### Why does a script using `/bin/rm` bypass RMGuard?

RMGuard works through a shell function named `rm`. Absolute paths such as
`/bin/rm` and commands such as `command rm` intentionally bypass shell functions.

## Bypass And Safety

### How do I bypass RMGuard?

Use a bypass only when you are sure about the target.

```bash
RM_GUARD=0 rm -rf /path
rm --no-guard -rf /path
```

### Can RMGuard stop every destructive command?

No. It only guards `rm` calls that go through the loaded shell function. It does
not protect direct filesystem writes, other deletion tools, or scripts that
bypass the shell function.

## Releases

### Should I use `v1.0.0` or `1.0.0`?

Use `v1.0.0` for the Git tag and GitHub Release. Use `1.0.0` for the internal
version and package name, such as `rmguard_1.0.0_all.deb`.

### Where are release notes?

Release notes live in `docs/releases/`.

### Where can I support the project?

You can sponsor the author through GitHub Sponsors:

```text
https://github.com/sponsors/Happyuky7
```

The author website is:

```text
https://happyuky7.github.io/
```
