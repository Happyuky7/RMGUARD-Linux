# RMGuard

[English](README.md) | [Espanol](README.es.md) | [Portugues](README.pt-BR.md) | Francais | [简体中文](README.zh-CN.md)

**RMGuard** protege les shells Linux interactifs contre les commandes `rm`
dangereuses comme `rm -rf /etc` ou `rm -rf /`, sans remplacer `/bin/rm`.

Site et docs : [GitHub Pages](docs/index.html) | [FAQ](docs/FAQ.md) | [Command Reference](docs/COMMANDS.md)

Auteur : [happyuky7.github.io](https://happyuky7.github.io/) | Sponsor : [GitHub Sponsors](https://github.com/sponsors/Happyuky7)

## Installation

```bash
git clone -b v1.0.0 https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux
chmod +x scripts/*.sh src/rmguard src/rmguard-cli test/rmguard_test.sh
sudo bash ./scripts/install.sh
source /etc/profile
rmguard --status
```

## Utilisation

Utilisez `rm` normalement :

```bash
rm -rf dossier
```

Les commandes dangereuses sont bloquees :

```bash
rm -rf /etc
rm -rf /
```

Pour forcer explicitement :

```bash
RM_GUARD=0 rm -rf /chemin
rm --no-guard -rf /chemin
```

## Documentation

- [Getting Started](docs/GETTING_STARTED.md)
- [Command Reference](docs/COMMANDS.md)
- [FAQ](docs/FAQ.md)
- [Release v1.0.0](docs/releases/v1.0.0.md)

## Licence

MIT. Voir [LICENSE](LICENSE).
