# ============================================================
# Curso 20953: Análisis de Datos Biológicos bajo R
# Taller Semana 1 — Tipos de datos y vectores en R
# Estación Repelón, departamento del Atlántico
# ============================================================
# Nombre: ___________________________________
# Fecha:  ___________________________________
# ============================================================
# INSTRUCCIONES:
# 1. Completa todos los espacios marcados con ___ o [COMPLETAR]
# 2. Responde las preguntas de reflexión como comentarios (#)
# 3. El script debe ejecutarse sin errores de principio a fin
# 4. Entrega este archivo como: taller1_apellido_nombre.R
# ============================================================


# ===========================================================
# DATASET — Ejecuta este bloque completo antes de comenzar
# ===========================================================

set.seed(42)  # NO modificar — garantiza reproducibilidad

meses <- c("ene", "feb", "mar", "abr", "may", "jun",
           "jul", "ago", "sep", "oct", "nov", "dic")

# Temperatura máxima mensual en Repelón (°C) — IDEAM
temp_max_repelón <- c(35.2, 35.8, 36.4, 34.7, 33.1, 34.0,
                      35.5, 33.8, 32.6, 32.1, 32.9, 34.6)

# Precipitación mensual promedio en Repelón (mm) — IDEAM
precip_repelón <- c(4.2, 1.5, 2.8, 45.6, 112.3, 98.7,
                    60.4, 125.1, 198.6, 165.3, 72.1, 11.4)

names(temp_max_repelón) <- meses
names(precip_repelón)   <- meses


# ===========================================================
# PARTE 1: Tipos de datos y exploración inicial
# ===========================================================

# --- 1.1 Verifica los tipos de datos ---

# Tipo del vector de temperatura:
class(___)

# Tipo del vector de precipitación:
class(___)

# Tipo del vector de meses:
class(___)

# ¿Es numérico el vector de precipitación?
is.numeric(___)

# ¿Es character el vector de meses?
is.character(___)

# Crea un entero con los años de registro de la estación Repelón (usa L):
años_registro <- ___
class(años_registro)

# Crea un lógico: ¿tiene el embalse del Guájaro influencia sobre el microclima?
influencia_embalse <- ___
class(influencia_embalse)

# Crea un factor con tipos de cobertura vegetal observados.
# Niveles posibles: "herbazal", "matorral", "bosque seco", "manglar"
# Datos observados: herbazal, matorral, herbazal, bosque seco, matorral
cobertura <- factor(
  c(___),
  levels = c(___)
)
class(cobertura)
levels(cobertura)

# --- PREGUNTAS DE REFLEXIÓN 1.1 ---
# Responde aquí con comentarios (#):

# 1. ¿Por qué declarar el conteo de años como integer y no como numeric?
#    ¿Tiene consecuencias prácticas en R?
# R:

# 2. El objeto cobertura tiene el nivel "manglar" aunque no aparece en los datos.
#    ¿Por qué puede ser útil incluir niveles sin observaciones en un estudio de vegetación?
# R:


# --- 1.2 Estadísticas de resumen ---

cat("=== TEMPERATURA MÁXIMA — Repelón (IDEAM) ===\n")
cat("Mínima mensual :", min(___), "°C —", names(which.min(___)), "\n")
cat("Máxima mensual :", max(___), "°C —", names(which.max(___)), "\n")
cat("Media anual    :", round(mean(___), 2), "°C\n")
cat("Rango          :", round(diff(range(___)), 2), "°C\n\n")

cat("=== PRECIPITACIÓN — Repelón (IDEAM) ===\n")
cat("Total anual    :", sum(___), "mm\n")
cat("Mes más seco   :", names(which.min(___)), "con", min(___), "mm\n")
cat("Mes más lluvioso:", names(which.max(___)), "con", max(___), "mm\n")

# --- PREGUNTAS DE REFLEXIÓN 1.2 ---

# 1. Los meses secos superan los 35°C. ¿Qué consecuencias fisiológicas
#    puede tener esto para anfibios o reptiles de la región?
# R:

# 2. ¿El total anual de Repelón es mayor o menor que el de Barranquilla (922 mm)?
#    ¿A qué factores lo atribuyes?
# R:


# ===========================================================
# PARTE 2: Indexación y operaciones vectorizadas
# ===========================================================

# --- 2.1 Acceso por posición y nombre ---

# Temperatura de marzo (posición 3):
temp_max_repelón[___]

# Precipitación de septiembre (por nombre):
precip_repelón["___"]

# Temperaturas del segundo semestre (posiciones 7 a 12):
temp_max_repelón[___]

# Precipitaciones de los meses de transición (abr, may, ago, sep):
precip_repelón[c("___", "___", "___", "___")]


# --- 2.2 Filtros lógicos vectorizados ---

# Meses con temperatura máxima mayor a 34°C:
meses_calidos <- meses[temp_max_repelón > ___]
cat("Meses con temp. máx. > 34°C:", paste(meses_calidos, collapse = ", "), "\n")

# Cuántos meses tienen precipitación mayor a 80 mm:
n_meses_lluviosos <- sum(precip_repelón > ___)
cat("Meses con precipitación > 80 mm:", n_meses_lluviosos, "\n")

# Meses con alta temperatura (> 34°C) Y baja precipitación (< 20 mm):
estres_hidrico <- meses[temp_max_repelón > ___ & precip_repelón < ___]
cat("Meses de potencial estrés hídrico:", paste(estres_hidrico, collapse = ", "), "\n")

# --- PREGUNTAS DE REFLEXIÓN 2 ---

# 1. ¿Qué especie del Atlántico es más vulnerable durante los meses de estrés hídrico?
# R:

# 2. ¿En qué semestre se concentran las lluvias? Compara con Barranquilla.
# R:

# 3. Cambia el umbral de temperatura de > 34 a > 35. ¿Cuántos meses quedan?
#    ¿Cómo cambia la interpretación biológica?
meses_muy_calidos <- meses[temp_max_repelón > ___]
cat("Meses con temp. máx. > 35°C:", paste(meses_muy_calidos, collapse = ", "), "\n")
# R (interpretación):


# --- 2.3 Operaciones vectorizadas ---

# Anomalía de temperatura (resta la media al vector completo):
anomalia_temp <- temp_max_repelón - ___
names(anomalia_temp) <- meses
cat("Anomalía de temperatura por mes (°C):\n")
print(round(anomalia_temp, 2))

# Precipitación acumulada por semestre:
precip_sem1 <- sum(precip_repelón[___])  # enero a junio
precip_sem2 <- sum(precip_repelón[___])  # julio a diciembre
cat("\nPrecipitación primer semestre :", round(precip_sem1, 1), "mm\n")
cat("Precipitación segundo semestre:", round(precip_sem2, 1), "mm\n")
cat("Diferencia                    :", round(precip_sem2 - precip_sem1, 1), "mm\n")

# Precipitación en cm para los primeros 6 meses:
precip_cm <- precip_repelón / ___
cat("\nPrecipitación en cm (primeros 6 meses):\n")
print(round(precip_cm[1:6], 2))


# ===========================================================
# PARTE 3: Visualización con R base
# ===========================================================

# --- 3.1 Barplot: precipitación mensual ---

# Umbral = media mensual de precipitación en Repelón:
umbral_precip <- ___

barplot(
  ___,                          # vector de precipitación
  names.arg = ___,              # nombres de los meses
  main = "Precipitación mensual promedio — Repelón, Atlántico (IDEAM)",
  xlab = "Mes",
  ylab = "Precipitación (mm)",
  col  = ifelse(___ > umbral_precip, "#1d4ed8", "#bfdbfe"),  # azul oscuro si supera la media
  las  = 1,
  ylim = c(0, 230)
)

# Línea horizontal en la media:
abline(h = ___, lty = 2, col = "darkred", lwd = 1.5)

# Leyenda:
legend(
  "topleft",
  legend = c(
    paste0("Sobre la media (> ", round(umbral_precip, 1), " mm)"),
    paste0("Bajo la media (≤ ", round(umbral_precip, 1), " mm)"),
    "Media mensual"
  ),
  fill   = c("#1d4ed8", "#bfdbfe", NA),
  lty    = c(NA, NA, 2),
  col    = c(NA, NA, "darkred"),
  border = c("black", "black", NA),
  bty    = "n",
  cex    = 0.82
)


# --- 3.2 Lineplot: temperatura máxima mensual ---

plot(
  1:12, ___,                  # eje x: posiciones; eje y: temperatura
  type = "b",
  pch  = 19,
  col  = "#b45309",
  lwd  = 2,
  main = "Temperatura máxima mensual — Repelón, Atlántico (IDEAM)",
  xlab = "Mes",
  ylab = "Temperatura máxima (°C)",
  xaxt = "n",
  ylim = c(30, 38)
)

# Eje x con nombres de meses:
axis(1, at = 1:12, labels = ___)

# Línea de la media anual:
abline(h = mean(___), lty = 2, col = "gray40", lwd = 1.5)

# Etiqueta de la media:
text(
  x = 0.6,
  y = mean(___) + 0.25,
  labels = paste("Media:", round(mean(___), 1), "°C"),
  cex = 0.82, col = "gray30", adj = 0
)


# --- 3.3 Climograma simplificado (desafío) ---

# Factor de escala para superponer temperatura y precipitación:
factor_escala <- max(temp_max_repelón) / max(precip_repelón)

# Colores por semestre: primer semestre (ene-jun) = un color, segundo (jul-dic) = otro
# Modifica los colores a tu gusto:
colores_sem <- c(rep("___", 6), rep("___", 6))

# Barplot de precipitación:
bp <- barplot(
  ___,
  col    = colores_sem,
  border = "#3b82f6",
  names.arg = meses,
  main   = "Climograma — Repelón, Atlántico (IDEAM)",
  xlab   = "Mes",
  ylab   = "Precipitación (mm)",
  ylim   = c(0, max(precip_repelón) * 1.15),
  las    = 1
)

# Superponer temperatura como línea (usar factor_escala para escalar):
lines(
  bp,
  temp_max_repelón / ___,
  type = "b", col = "#b91c1c", pch = 19, lwd = 2
)

# Segundo eje para temperatura (lado derecho):
axis(
  side = 4,
  at   = seq(0, max(precip_repelón), length.out = 5),
  labels = round(seq(0, max(precip_repelón), length.out = 5) * factor_escala, 1),
  col.axis = "#b91c1c"
)
mtext("Temperatura máxima (°C)", side = 4, line = 3, col = "#b91c1c", cex = 0.9)

# Leyenda (actualiza con los colores semestrales que elegiste):
legend(
  "topleft",
  legend = c("Precipitación 1er semestre", "Precipitación 2do semestre", "Temp. máxima (°C)"),
  fill   = c("___", "___", NA),
  lty    = c(NA, NA, 1),
  pch    = c(NA, NA, 19),
  col    = c(NA, NA, "#b91c1c"),
  border = c("#3b82f6", "#3b82f6", NA),
  bty    = "n", cex = 0.82
)

# --- PREGUNTAS DE REFLEXIÓN 3 ---

# 1. ¿Cómo afectan los periodos secos y calurosos a los recursos hídricos
#    para anfibios y plantas del sur del Atlántico?
# R:

# 2. Amplitud de variación: Repelón (~4°C) vs. Barranquilla (~2°C).
#    ¿Qué diferencia esperas en la diversidad de ectotérmicos entre ambos sitios?
# R:


# ===========================================================
# FIN DEL TALLER
# Verifica que el script corre de inicio a fin sin errores
# antes de entregarlo.
# ===========================================================
