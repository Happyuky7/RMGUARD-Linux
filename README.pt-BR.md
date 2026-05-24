# RMGuard

[English](README.md) | [Espanol](README.es.md) | Portugues | [Francais](README.fr.md) | [简体中文](README.zh-CN.md)

**RMGuard** protege shells interativos Linux contra comandos `rm` perigosos,
como `rm -rf /etc` ou `rm -rf /`, sem substituir `/bin/rm`.

Site e docs: [GitHub Pages](docs/index.html) | [FAQ](docs/FAQ.md) | [Command Reference](docs/COMMANDS.md)

Autor: [happyuky7.github.io](https://happyuky7.github.io/) | Sponsor: [GitHub Sponsors](https://github.com/sponsors/Happyuky7)

## Instalacao

```bash
git clone -b v1.0.0 https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux
chmod +x scripts/*.sh src/rmguard src/rmguard-cli test/rmguard_test.sh
sudo bash ./scripts/install.sh
source /etc/profile
rmguard --status
```

## Uso

Use `rm` normalmente:

```bash
rm -rf pasta
```

Comandos perigosos sao bloqueados:

```bash
rm -rf /etc
rm -rf /
```

Para executar de forma explicita:

```bash
RM_GUARD=0 rm -rf /caminho
rm --no-guard -rf /caminho
```

## Documentacao

- [Getting Started](docs/GETTING_STARTED.md)
- [Command Reference](docs/COMMANDS.md)
- [FAQ](docs/FAQ.md)
- [Release v1.0.0](docs/releases/v1.0.0.md)

## Licenca

MIT. Veja [LICENSE](LICENSE).
