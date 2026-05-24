# rmguard

🇪🇸 Español | [�🇳 简体中文](README.zh-CN.md) | [�🇬🇧 English](README.md)

**rmguard** protege contra comandos `rm` peligrosos (por ejemplo, `rm -f /*` o `rm -rf /etc`) sin romper scripts del sistema.  
Se carga solo en shells interactivos (p. ej., cuando una persona está en SSH/TTY) y permite forzar de forma explícita si de verdad lo necesitas.

## 🔒 Características

- ✅ **Bloquea el borrado de** `"/"` y de rutas de primer nivel (`/bin`, `/etc`, `/var`, …).
- ✅ **Permite por defecto** `/tmp` y `/var/tmp` (configurable).
- ✅ **No reemplaza** `/bin/rm`: define una función `rm` que llama a `/usr/lib/rmguard/rmguard`.
- ✅ **Para forzar**: `RM_GUARD=0 rm …` o `rm --no-guard …`.

⚠️ **Nota**: si un script invoca `/bin/rm` con ruta absoluta o usa `command rm`, no pasará por rmguard. Recomendación: en tus scripts usa `rm` sin ruta.

---

## 📋 Tabla de contenidos

- [Instalación](#instalación)
- [Guía de inicio](docs/GETTING_STARTED.md)
- [Uso](#uso)
- [Comandos](#comandos)
- [Configuración](#configuración)
- [Pruebas](#pruebas)
- [Desinstalación](#desinstalación)
- [Diseño y decisiones](#diseño-y-decisiones)
- [Solución de problemas](#solución-de-problemas)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Licencia](#licencia)

---

## 🚀 Instalación

**⚠️ Importante**: Una vez instalado, rmguard estará **activo automáticamente** en todas las nuevas sesiones interactivas (SSH, terminal). Solo necesitas ejecutar `source /etc/profile` **una vez** para activarlo en la sesión actual después de instalar.

### Método 1: Instalación manual (git clone)

```bash
git clone https://github.com/Happyuky7/RMGUARD-Linux.git
cd RMGUARD-Linux
chmod +x scripts/*.sh src/rmguard src/rmguard-cli test/rmguard_test.sh
sudo bash ./scripts/install.sh
# Actívalo en la sesión actual o abre una nueva:
source /etc/profile
```

### Método 2: Instalar desde paquete .deb

Si la release tiene un paquete `.deb` adjunto, descárgalo desde
[Releases](https://github.com/Happyuky7/RMGUARD-Linux/releases) e instala:

```bash
# Descarga la última versión
wget https://github.com/Happyuky7/RMGUARD-Linux/releases/latest/download/rmguard_0.0.2_all.deb

# Instalar
sudo apt install ./rmguard_0.0.2_all.deb

# Activarlo en la sesión actual (solo una vez)
source /etc/profile
```

### ✅ Verificar instalación

```bash
# Verificar que rmguard está activo
rmguard --status

# O verificar manualmente
type rm
# Puede mostrar primero el alias de rmguard; rmguard --status debe reportar ACTIVE.
```

---

## 💻 Uso

Igual que siempre:

```bash
rm -rf carpeta
```

Si intentas algo riesgoso:

```bash
rm -f /*         # → bloqueado
rm -rf /etc      # → bloqueado
```

Para forzar (solo si sabes lo que haces):

```bash
RM_GUARD=0 rm -rf /etc
# o:
rm --no-guard -rf /etc
```

---

## 🛠️ Comandos

### Mostrar ayuda

```bash
rmguard --help
# o
rmguard -h
```

### Mostrar versión

```bash
rmguard --version
# o
rmguard -v
```

### Verificar estado de rmguard

```bash
rmguard --status
# o
rmguard -s
```

### Verificar actualizaciones

```bash
rmguard --check-updates
# o
rmguard -c

# Si hay actualización disponible, te preguntará si quieres instalarla
```

### Lista completa de comandos

| Comando | Alias | Descripción |
|---------|-------|-------------|
| `rmguard --help` | `-h` | Muestra el menú de ayuda completo |
| `rmguard --version` | `-v` | Muestra la versión instalada |
| `rmguard --status` | `-s` | Verifica si rmguard está activo |
| `rmguard --check-updates` | `-c` | Busca actualizaciones y permite instalarlas |

### Desactivar rmguard temporalmente

```bash
# Opción 1: Para un comando específico
RM_GUARD=0 rm -rf /ruta/peligrosa

# Opción 2: Usar flag --no-guard
rm --no-guard -rf /ruta/peligrosa

# Opción 3: Desactivar en la sesión actual
unset -f rm
export RM_GUARD=0
```

---

## ⚙️ Configuración

**Archivo**: `/etc/rmguard.conf`

```bash
# Desactivar globalmente (no recomendado)
# RM_GUARD=0

# Toplevels permitidos (por defecto /tmp y /var/tmp)
ALLOW_TOPLEVEL="/tmp /var/tmp"
```

---

## 🧪 Pruebas

```bash
# Bloquea rutas de primer nivel
rm -rf /etc || echo "OK: bloqueado /etc"

# Permite /tmp
touch /tmp/x && rm -f /tmp/x && echo "OK: /tmp permitido"

# Test automatizado:
sudo bash ./test/rmguard_test.sh
```

---

## 🗑️ Desinstalación

```bash
cd rmguard/scripts
sudo ./uninstall.sh
```

---

## 🏗️ Diseño y decisiones

1. **Solo shells interactivos**: se carga a través de `/etc/profile.d`, evitando romper servicios o scripts del sistema.
2. **No toca `/bin/rm` ni lo reemplaza**: expone una función `rm()` que invoca `/usr/lib/rmguard/rmguard`.
3. **Bloqueo seguro por defecto**: evita `"/"` y rutas de primer nivel (p.ej. `/bin`, `/etc`, `/var`), excepto una lista blanca (`/tmp`, `/var/tmp`) configurable.
4. **Forzable de forma explícita**: `RM_GUARD=0` o `--no-guard` cuando necesitas ejecutar algo excepcional y consciente.
5. **Alias amable**: `-I` y `--preserve-root=all` añaden fricción positiva; no sustituyen las reglas del guard.
6. **Persistente**: Una vez instalado, se activa automáticamente en cada nueva sesión sin necesidad de configuración adicional.

---

## 🔄 Funcionamiento automático

### ✅ rmguard se activa automáticamente en:
- Nuevas terminales abiertas
- Sesiones SSH
- Shells bash interactivos
- Después de reinicios del sistema

### ❌ rmguard NO se activa en:
- Scripts del sistema (para no romper servicios)
- Cron jobs
- Servicios systemd
- Scripts que usan `/bin/rm` con ruta absoluta

### 📋 Verificar si está activo

```bash
# Método 1: Usar comando de estado
rmguard --status

# Método 2: Verificar manualmente
type rm
# Puede mostrar primero el alias de rmguard; rmguard --status debe reportar ACTIVE.

# Método 3: Ver variable de entorno
echo $RM_GUARD
# Salida esperada: 1 (activo) o vacío/0 (inactivo)
```

---

## 🔧 Solución de problemas

### "Mi script no pasa por rmguard"
Si usa `/bin/rm` (ruta absoluta) o `command rm`, evita la función shell. **Recomendación**: en scripts propios usar `rm` sin ruta.

### "No se activa rmguard tras instalar"
Abre una nueva sesión o ejecuta `source /etc/profile`. Verifica con:

```bash
type rm   # puede mostrar primero el alias de rmguard
```

### "Necesito permitir otra ruta de primer nivel"
Edita `/etc/rmguard.conf` y agrega en `ALLOW_TOPLEVEL` (⚠️ con cuidado).

### "¿Cómo desactivo rmguard temporalmente?"
Ver sección [Desactivar rmguard temporalmente](#desactivar-rmguard-temporalmente) en Comandos.

### "¿rmguard estará activo después de reiniciar?"
Sí, rmguard se activa automáticamente en cada nueva sesión después de instalarlo. No necesitas volver a configurarlo.

---

## 📁 Estructura del proyecto

```
rmguard/
├─ src/
│  └─ rmguard                 # binario principal (wrapper)
├─ etc/
│  └─ profile.d/
│     └─ rmguard.sh           # activa rmguard en shells interactivos
├─ config/
│  └─ rmguard.conf            # config opcional (whitelist toplevels)
├─ scripts/
│  ├─ install.sh              # instalación manual (git clone)
│  ├─ uninstall.sh            # desinstalación manual
│  └─ package.sh              # genera rmguard_0.0.2_all.deb
├─ test/
│  └─ rmguard_test.sh         # pruebas rápidas
├─ README.md                  # documentación en inglés
├─ README.es.md               # documentación en español
├─ README.zh-CN.md            # documentación en chino simplificado
└─ LICENSE
```

---

## 📄 Licencia

**MIT License** — Ver archivo [LICENSE](LICENSE) para más detalles.

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## � Construir paquete .deb

Si quieres construir el paquete `.deb` tú mismo:

```bash
bash ./scripts/package.sh 0.0.2

# El paquete se creará en:
# build/rmguard_0.0.2_all.deb
```

Para crear releases:

```bash
bash ./scripts/release.sh 0.0.2
```

---

## 🔮 Implementaciones futuras

- 🚧 **Repositorio APT**: Publicación en repositorio oficial para instalación más fácil
- 🚧 **Auto-actualizaciones via APT**: Actualizaciones automáticas del sistema

---

## ⚠️ Advertencia

Este software es una capa de protección adicional pero **NO** es infalible. Siempre ten cuidado al ejecutar comandos destructivos en sistemas de producción.

---

**Desarrollado con ❤️ por [Happyuky7](https://github.com/Happyuky7) para proteger tus sistemas Linux**
