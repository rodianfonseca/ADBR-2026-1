# Guía de publicación — Sitio web Curso 20953

## Requisitos previos

```bash
# Instalar Quarto CLI (si no está instalado)
# https://quarto.org/docs/get-started/

quarto --version  # verificar instalación (se requiere ≥ 1.4)
```

## Construir el sitio localmente

```bash
# Desde la carpeta sitio-web/
cd "sitio-web"

# Vista previa (servidor local en http://localhost:4848)
quarto preview

# Construir el sitio estático (genera la carpeta _site/)
quarto render
```

## Actualizar calificaciones

1. Abrir `datos/notas.json`
2. Localizar al estudiante por `"documento"` (número de cédula)
3. Cambiar `null` por la nota correspondiente (número entre 0.0 y 5.0)
4. Agregar retroalimentación textual en el campo `"retroalimentacion"` correspondiente
5. Actualizar el campo `"actualizado"` con la fecha actual (formato `YYYY-MM-DD`)
6. Ejecutar `quarto render` para reconstruir el sitio
7. Subir la carpeta `_site/` al servidor

**Ejemplo:**
```json
{
  "documento": "1010124907",
  "nombre": "Josué Jesús Garizábalo Flórez",
  "notas": {
    "S1": 4.2,
    "S2": null,
    ...
  },
  "retroalimentacion": {
    "S1": "Excelente manejo de vectores. Mejorar los comentarios en el código.",
    ...
  }
}
```

## Agregar material de una nueva semana

1. Crear `semanas/semana-N.qmd` con el script de la semana convertido a formato Quarto
2. Actualizar `material.qmd` para publicar la semana (quitar `opacity:0.6` y el badge "Pendiente")
3. Actualizar `_quarto.yml` → sección `menu` del navbar para incluir el enlace

## Publicación en servidor

### Opción A: Servidor web estático (Apache / Nginx)

```bash
# Construir el sitio
quarto render

# Copiar la carpeta _site/ al servidor
rsync -avz _site/ usuario@servidor:/var/www/html/biologia-r/
```

### Opción B: GitHub Pages

```bash
# Configurar en _quarto.yml:
# project:
#   output-dir: docs

quarto render

# Subir la carpeta docs/ a GitHub
git add docs/
git commit -m "Actualización del sitio"
git push

# En GitHub: Settings → Pages → Source: docs/
```

### Opción C: Netlify (drag & drop)

1. Ejecutar `quarto render`
2. Ir a [netlify.com](https://netlify.com) → "Deploy manually"
3. Arrastrar la carpeta `_site/` al área de despliegue

### Opción D: Quarto Pub (gratuito)

```bash
# Publicar directamente desde la terminal
quarto publish quarto-pub
```

## Estructura del sitio generado

```
_site/
├── index.html          ← Página de inicio
├── cronograma.html     ← Cronograma completo
├── material.html       ← Material descargable por semana
├── calificaciones.html ← Formulario de consulta de notas
├── semanas/
│   └── semana-1.html   ← Script semana 1 renderizado
└── datos/
    └── notas.json      ← Base de datos de calificaciones
```

## Notas importantes

- El formulario de calificaciones requiere que el sitio esté **servido por un servidor HTTP** 
  (no funciona con `file://`). En vista previa local (`quarto preview`) sí funciona.
- Los datos de `notas.json` son accesibles públicamente si el servidor no requiere autenticación.
  Esto es apropiado para calificaciones universitarias colombianas bajo la ley de protección de datos,
  ya que solo son accesibles con el número de documento del estudiante.
- Para mayor seguridad, considerar proteger el sitio con autenticación HTTP básica en el servidor.
