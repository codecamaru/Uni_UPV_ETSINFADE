################################################################################
#   Práctica de Investigación Comercial
#
#   PROYECTO: ANÁLISIS DE LOS DATOS DE LA ENCUESTA
#
#     Se proporciona el archivo con los datos recogidos
#     Cuestionario: https://docs.google.com/forms/d/12gw9VKNHcb7Zv3u5tDXX9i9sd_nSuJXGcNsOaZiNXgo/edit#question=651350677&field=1871292736
#
################################################################################


# ============================================================================
# LIBRERÍAS
# ============================================================================

library(descr)
library(psych)
library(readxl)
library(sjPlot)
library(splitstackshape)
library(base)
library(clean)
library(cleaner)
library(datasets)
library(ggplot2)
library(graphics)
library(grDevices)
library(methods)
library(stats)
library(utils)
library(haven)

library(dplyr)
library(sjmisc)
library(parameters)

# ============================================================================
# CARGA DE DATOS
# ============================================================================

# el archivo de datos se encuentra en el mismo directorio
datos <- read_excel('Encuesta app de comidas (respuestas).xlsx')

# vemos la estructura de los datos
View(datos)

# ============================================================================
# PREPROCESADO: NOMBRE DE LAS VARIABLES
# ============================================================================

# cambiamos los nombres de las columnas de la tabla para reflejar las variables de la encuesta
colnames(datos) <- c( 'Marca_Temporal',              #Marca temporal
                      'Facilidad_idea',              #Preg. 1 ¿Con qué facilidad se te ocurren platos para comer?
                      'Bool_cocina',                 #Preg. 2 ¿Cocinas habitualmente?
                      'Nivel_preocupacion_dieta',    #Preg. 3 ¿Qué nivel de preocupación tienes por tu dieta?
                      'Nivel_afecta_alimentacion',   #Preg. 4 ¿Cómo consideras que está afectando tu alimentación actual a tu salud?
                      'Nivel_variedad',              #Preg. 5 ¿Qué nivel de variedad hay en tu dieta semanal?
                      'Predisposicion_saludable',    #Preg. 6 ¿Te gusta comer sano? (o, te gustaría, si no lo haces ya)
                      'Cantidad_comida_diaria',      #Preg. 7 ¿Cuántas comidas realizas al día?
                      'Bool_consumo',                #Preg. 8 ¿Consumes alcohol o drogas?
                      'Bool_uso_otra_app',           #Preg. 9 ¿Actualmente utilizas una aplicación para cocinar?
                      'Bool_usarias',                #Preg. 10 ¿Estarías interesado/a en utilizar “Oma cooking”?
                      'Asociacion_marca',            #Preg. 11 ¿Te sentirías más cómodo/a en el uso de Oma cooking si nos asociamos con otra marca?
                      'Marca',                       #Preg. 12 ¿Con cuál de las siguientes marcas?
                      'Edad',                        #Preg. 13 ¿Cuál es tu edad?
                      'Genero',                      #Preg. 14 ¿Cuál es tu género?
                      'Nivel_estudios',              #Preg. 15 ¿Cuál es el mayor nivel de estudios que has adquirido o estás cursando?
                      'Frecuencia_actividad',        #Preg. 16 ¿Con qué frecuencia realizas actividad física durante la semana?
                      'Problema_tiempo',             #Preg. 17 Si tuvieras que preparar la comida ¿En qué medida el tiempo te resulta un factor de dificultad?
                      'Bool_nuevos_platos',          #Preg. 18 ¿Te gusta probar nuevos platos (comidas)?
                      'Preferencias_alimentacion',   #Preg. 19 ¿Qué preferencias o necesidades tienes en tu alimentación?
                      'Convivencia'                  #Preg. 20 ¿Con quién vives habitualmente?
)
# vemos cómo ha quedado la tabla
View(datos)

# =================================================================================
# PREPROCESADO: TRANSFORMACIÓN DE LAS VARIABLES CATEGÓRICAS: DE TEXTO A FACTORES
# =================================================================================
datos$f_Bool_cocina <- factor(datos$Bool_cocina, 
                              levels = c('Sí', 'No'))
datos$f_Bool_consumo <- factor(datos$Bool_consumo, 
                               levels = c('Sí', 'No'))
datos$f_Bool_uso_otra_app <- factor(datos$Bool_uso_otra_app, 
                                    levels = c('Si', 'No'))
datos$f_Bool_usarias <- factor(datos$Bool_usarias, 
                               levels = c('Sí', 'No'))
datos$f_Bool_nuevos_platos <- factor(datos$Bool_nuevos_platos, 
                                     levels = c('Sí', 'No'))

datos$f_Nivel_afecta_alimentacion <- factor(datos$Nivel_afecta_alimentacion,
                                            levels = c('Positivamente', 'Considero que no le afecta', 
                                                       'Negativamente'))
datos$f_Predisposicion_saludable <- factor(datos$Predisposicion_saludable, 
                                           levels = c('Sí', 'Me es indiferente', 
                                                      'No'))
datos$f_Asociacion_marca <- factor(datos$Asociacion_marca, 
                                           levels = c('Sí', 'Me es indiferente', 
                                                      'No', NA))
datos$f_Edad <- factor(datos$Edad, levels = c('De 16 a 17 años','De 18 a 34 años', 'De 35 a 50', 
                                                    'Mas de 50'))
datos$f_Genero <- factor(datos$Genero, levels = c('Femenino', 'Masculino', 'No binario', 
                                                'Prefiero no contestar'))
datos$f_Nivel_estudios <- factor(datos$Nivel_estudios, levels = c('Primaria', 'Secundaria', 
                                                'Bachillerato o equivalente', 'Grado Medio', 
                                                'Grado Superior','Grado Universitario', 'Master', 
                                                'Doctorado', 'Oposición', 'y el graduado de la vida'))
datos$f_Frecuencia_actividad <- factor(datos$Frecuencia_actividad, levels = c('0 días a la semana',
                                                'Un día a la semana', 'Entre 2 y 3 días a la semana',
                                                '4 o más días a la semana'))
# categorizamos dos variables en un solo nivel
levels(datos$f_Frecuencia_actividad) <- list(
  'Poca actividad' = c('0 días a la semana','Un día a la semana'),
  'Mucha actividad' = c('Entre 2 y 3 días a la semana', '4 o más días a la semana')
)

# =================================================================================
# PREPROCESADO: CREAMOS VARIABLES CATEGÓRICAS PARA LAS ESCALAS DE LIKERT
# =================================================================================
#Facilidad con la que se te ocurren platos para comer
datos$f_Facilidad_idea <- factor(datos$Facilidad_idea,  levels = c(1:5), 
                                 labels = c('Muy poca facilidad', 'Poca facilidad', 
                                            'Indiferente', 'Tengo facilidad', 'Mucha facilidad'))
#Nivel de preocupación por la dieta
datos$f_Nivel_preocupacion_dieta <- factor(datos$Nivel_preocupacion_dieta,  levels = c(1:5), 
                                  labels = c('No pienso en lo que como', 'Pienso poco en lo que como', 
                                             'Indiferente', 'Algo de importancia', 'La considero de gran importancia'))
#Variedad de comidas en tu dieta semanal
datos$f_Nivel_variedad <- factor(datos$Nivel_variedad, levels = c(1:5),
                                  labels = c('Siempre como lo mismo', 'Varío poco', 'Indiferente',
                                              'Suelo variar', 'Cada día como algo diferente'))
#El tiempo como factor de dificultad para cocinar
datos$f_Problema_tiempo <- factor(datos$Problema_tiempo, levels = c(1:5),
                                  labels = c('no lo veo como una dificultad añadida', 'Poca dificultad añadida', 'Indiferente',
                                             'Difícil en parte', 'lo veo como una gran dificultad añadida'))


# =================================================================================
# PREPROCESADO: PREGUNTAS CERRADAS CON VARIAS RESPUESTAS POSIBLES
# =================================================================================
datos <- cSplit_e(datos, 'Marca', sep = ', ', type = 'character', fill = NA)
datos <- cSplit_e(datos, 'Preferencias_alimentacion', sep = ', ', type = 'character', fill = 0)
datos <- cSplit_e(datos, 'Convivencia', sep = ', ', type = 'character', fill = 0)

# Vemos cómo ha quedado la tabla de los datos
View(datos)

# ============================================================================
# CONTROL DE CONSISTENCIA DE LA ENCUESTA
# ============================================================================
datos$f_Preferencias_alimentacionControl <- factor(datos$Preferencias_alimentacion,
                                                   levels = c('Vegano/a', 'Vegetariano/a', 'Alergia/s', 'Intolerancia/s', 
                                                              'Prefiero mayor cantidad de proteína', 'Prefiero mayor cantidad de fibra',
                                                              'Prefiero mayor cantidad de grasa' , 'Tengo alergia a los cuestionarios', 'Variedad', 
                                                              'Ninguna', 'no tengo preferencias', 'Mediterránea y variada', 
                                                              'Simplemente quiero una dieta equilibrada', 'ninguna', 
                                                              'prefiero no tomar carne ni leche de vaca', 
                                                              'Ninguna preferencia', 'Variado', 'No tengo ninguna preferencia', 'Mediterránea', 
                                                              'De todo un poco', 'Celiaquía (No es una intolerancia ni una alergia)', 'nada', 
                                                              'Diabetes', 'Comer de todo', 'Variada', 'Lo que sea más apropiado para mi',
                                                              'Depende del momento.', 'No tengo limitaciones biológicas, como todo', 'Evitar procesados', 
                                                              'No tengo preferencias'), 
                                                   exclude = NULL)

datos <- subset(datos, f_Preferencias_alimentacionControl != 'Tengo alergia a los cuestionarios')
View(datos) # tras eliminar respuestas inválidas con la pregunta de control, nos queda un total de 99 respuestas

# ============================================================================
# ANÁLISIS UNIVARIANTE: VARIABLES NUMÉRICAS Y DE ESCALA LIKERT
# ============================================================================

# Estadísticas básicas: describe{psych}
# construímos matriz con todos los datos provenientes de las variables numéricas (únicamente tenemos el nº diario de comidas)
datos.numericos <- cbind(datos$Cantidad_comida_diaria)
colnames(datos.numericos) <- c('Número de comidas diariaas')
describe(datos.numericos, fast = TRUE)    
# estos son los resultados obtenidos:
#     vars  n       mean   sd     min   max  range   se
# X1    1   99     3.71   0.93    2     5     3      0.09
# concluímos que en nuestra aplicación, no tendría sentido ofrecer más de 5 recetas para comidas diarias 
# y que, al menos, deberíamos ofrecer recetas para 3 comidas diarias



# FACILIDAD IDEA: escala Likert
# Histograma de frecuencias
#        obtenemos la tabla de frecuencias y el histograma
freq(datos$f_Facilidad_idea, 
     main='Facilidad con la que se generan ideas para recetas',
     xlab='Grado de acuerdo',
     ylab='Número de observaciones',
     ylim=c(0, 30))
# vamos a utilizar el paquete sjPlot, que proporciona gráficos para las barras Likert
# hemos de crear un dataframe con las escalas likert
datos.likert <- data.frame("Item1" = datos$f_Facilidad_idea)
# figura básica
plot_likert(datos.likert) 
# figura con más elementos
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('La falta de imaginación es el principal problema para generar recetas'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
# grabamos la figura
png('Facilidad.png') #ES NECESARIO VOLVER A PLOTEAR PARA GENERAR EL PNG
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('La falta de imaginación es el principal problema para generar recetas'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
dev.off()


# NIVEL VARIEDAD: escala Likert
# Histograma de frecuencias
#        obtenemos la tabla de frecuencias y el histograma
#        Además, ampliamos el límite del eje de las y
freq(datos$f_Nivel_variedad, 
     main='Variedad en las comidas',
     xlab='Grado de acuerdo',
     ylab='Número de observaciones',
     ylim=c(0, 60))
# vamos a utilizar el paquete sjPlot, que proporciona gráficos para las barras Likert
# hemos de crear un dataframe con las escalas likert
datos.likert <- data.frame("Item2" = datos$f_Nivel_variedad)
# figura básica
plot_likert(datos.likert) 
# figura con más elementos
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('¿Qué variedad alimenticia tenemos?'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
# grabamos la figura
png('Variedad.png')
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('¿Qué variedad alimenticia tenemos?'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
dev.off()

# DIFICULTAD TIEMPOR: escala Likert
# Histograma de frecuencias
#        obtenemos la tabla de frecuencias y el histograma
#        Además, ampliamos el límite del eje de las y
freq(datos$f_Problema_tiempo, 
     main='Dificultad que plantea el factor tiempo',
     xlab='Grado de acuerdo',
     ylab='Número de observaciones',
     ylim=c(0, 26))
# vamos a utilizar el paquete sjPlot, que proporciona gráficos para las barras Likert
# hemos de crear un dataframe con las escalas likert
datos.likert <- data.frame("Item3" = datos$f_Problema_tiempo)
# figura básica
plot_likert(datos.likert) 
# figura con más elementos
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('¿Es el tiempo una dificultad?'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
# grabamos la figura
png('TiempoDificultad.png')
plot_likert(datos.likert, 
            cat.neutral = 'Indiferente', catcount = 5, 
            values = "sum.outside",
            axis.titles = c( 'Ítems', 'Porcentaje'),
            axis.labels = c('¿Es el tiempo una dificultad?'),
            legend.title = 'Respuestas',
            show.prc.sign = TRUE,
            geom.colors = "RdBu"
) 
dev.off()

# ============================================================================
# ANÁLISIS UNIVARIANTE: VARIABLES CATEGÓRICAS O FACTORES
# ============================================================================

# obtenemos la tabla de frecuencias y el histograma de los RANGOS DE EDADES 
freq(datos$f_Edad, main='Histograma de rangos de edad', ylim=c(0,20))
# estos son los resultados obtenidos
# Frequency table 
# Class:      factor (numeric)
# Length:     99
# Levels:     4: De 16 a 17 años, De 18 a 34 años, De 35 a 50, Mas de 50
# Available:  99 (100%, NA: 0 = 0%)
# Unique:     4
#       Item                 Count    Percent    Cum. Count    Cum. Percent
# ---  -----------------  -------  ---------  ------------  --------------
# 1    De 18 a 34 años         45     45.45%            45          45.45%
# 2    Mas de 50               33     33.33%            78          78.79%
# 3    De 35 a 50              20     20.20%            98          98.99%
# 4    De 16 a 17 años          1      1.01%            99         100.00%
# concluímos que los individuos de nuestra muestra están bien distribuídos entre los rangos de edad
# distinguimos por género para obtener tabla con más información y poder elaborar la biestratificación
nH18_34 <- datos[datos$f_Edad == 'De 18 a 34 años' & datos$f_Genero == 'Masculino',]
nrow(nH18_34) # 26 hombres 
nM18_34 <- datos[datos$f_Edad == 'De 18 a 34 años' & datos$f_Genero == 'Femenino',]
nrow(nM18_34) # 17 mujeres 
nnB18_34 <- datos[datos$f_Edad == 'De 18 a 34 años' & datos$f_Genero == 'No binario',]
nrow(nnB18_34) # 1 noBinario
nNC18_34 <- datos[datos$f_Edad == 'De 18 a 34 años' & datos$f_Genero == 'Prefiero no contestar',]
nrow(nNC18_34) # 1 No contesta
nH16_17 <- datos[datos$f_Edad == 'De 16 a 17 años' & datos$f_Genero == 'Masculino',]
nrow(nH16_17) # 0 hombres 
nM16_17 <- datos[datos$f_Edad == 'De 16 a 17 años' & datos$f_Genero == 'Femenino',]
nrow(nM16_17) # 1 mujeres 
nnB16_17 <- datos[datos$f_Edad == 'De 16 a 17 años' & datos$f_Genero == 'No binario',]
nrow(nnB16_17) # 0 noBinario
nNC16_17 <- datos[datos$f_Edad == 'De 16 a 17 años' & datos$f_Genero == 'Prefiero no contestar',]
nrow(nNC16_17) # 0 No contesta
nH35_50 <- datos[datos$f_Edad == 'De 35 a 50' & datos$f_Genero == 'Masculino',]
nrow(nH35_50) # 7 hombres 
nM35_50 <- datos[datos$f_Edad == 'De 35 a 50' & datos$f_Genero == 'Femenino',]
nrow(nM35_50) # 12 mujeres 
nnB35_50 <- datos[datos$f_Edad == 'De 35 a 50' & datos$f_Genero == 'No binario',]
nrow(nnB35_50) # 0 noBinario
nNC35_50 <- datos[datos$f_Edad == 'De 35 a 50' & datos$f_Genero == 'Prefiero no contestar',]
nrow(nNC35_50) # 1 No contesta
nH50 <- datos[datos$f_Edad == 'Mas de 50' & datos$f_Genero == 'Masculino',]
nrow(nH50) # 10 hombres 
nM50 <- datos[datos$f_Edad == 'Mas de 50' & datos$f_Genero == 'Femenino',]
nrow(nM50) # 23 mujeres 
nnB50 <- datos[datos$f_Edad == 'Mas de 50' & datos$f_Genero == 'No binario',]
nrow(nnB50) # 0 noBinario
nNC50 <- datos[datos$f_Edad == 'Mas de 50' & datos$f_Genero == 'Prefiero no contestar',]
nrow(nNC50) # 0 No contesta

#una alternativa a la generación anterior de los histogramas es la siguiente:
# creamos un histograma con la variable FACILIDAD IDEA
ggplot(data.frame(datos$f_Facilidad_idea), aes(x=datos$f_Facilidad_idea)) + geom_bar()
# creamos un histograma con la variable NIVEL VARIEDAD
ggplot(data.frame(datos$f_Nivel_variedad), aes(x=datos$f_Nivel_variedad)) + geom_bar()
# creamos un histograma con la variable TIEMPO COMO DIFICULTAD
ggplot(data.frame(datos$f_Problema_tiempo), aes(x=datos$f_Problema_tiempo)) + geom_bar()


# ============================================================================
# ANÁLISIS BIVARIANTE: TABLAS DE CONTINGENCIA ENTRE VARIABLES CATEGÓRICAS
# ====·========================================================================

# Función crosstab{descr}
#         prop.c ---> proporción por columnas
#         prop.r ---> proporción por filas
#         chisq ---> pedimos la prueba de independencia del chi cuadrado

# PARA ACCEDER A LA VARIABLE VIVENCONSUSPADRES -> datos$Convivencia_Padres

# (SI,NO,NA vs SI,NO,NA)
# Relación entre la variable datos$Convivencia_Padres 
#       y la variable de datos$f_Bool_usarias
crosstab( dep = datos$f_Bool_usarias,             
          indep = datos$Convivencia_Padres, 
          prop.c = TRUE, prop.r = TRUE, chisq = TRUE, 
          dnn = c('Usarían nuestra aplicación', 'Vivir con los padres es el problema'))     # establecemos las etiquetas de x e y para la tabla y el gráfico
# Añadimos código para que se pueda grabar la imagen automáticamente
#       El inconveniente de esta función es que se tiene que saber 
#       con antelación el tamaño de la imagen a grabar
#       Por defecto, la función tiene:
#           width = 480, height = 480, units = "px"
#
# 1) creamos el fichero la imagen
jpeg('grafico usar_app padres_ppal_problema.jpg', quality = 100)
# 2) ejecutamos la función que además crea la imagen
crosstab( dep = datos$f_Bool_usarias,             
          indep = datos$Convivencia_Padres, 
          prop.c = TRUE, prop.r = TRUE, chisq = TRUE, 
          dnn = c('Usarían nuestra aplicación', 'Vivir con los padres es el problema'))     # establecemos las etiquetas de x e y para la tabla y el gráfico
# 3) desconectamos la imagen
dev.off()

# Relación entre la variable datos$f_Bool_cocina 
#       y la variable de datos$f_Bool_usarias
crosstab( dep = datos$f_Bool_usarias,             
          indep = datos$f_Bool_cocina, 
          prop.c = TRUE, prop.r = TRUE, chisq = TRUE, 
          dnn = c('Usarían nuestra aplicación', 'Cocinas'))     # establecemos las etiquetas de x e y para la tabla y el gráfico
# Añadimos código para que se pueda grabar la imagen automáticamente
#       El inconveniente de esta función es que se tiene que saber 
#       con antelación el tamaño de la imagen a grabar
#       Por defecto, la función tiene:
#           width = 480, height = 480, units = "px"
#
# 1) creamos el fichero la imagen
jpeg('grafico usar_app cocinas.jpg', quality = 100)
# 2) ejecutamos la función que además crea la imagen
crosstab( dep = datos$f_Bool_usarias,             
          indep = datos$f_Bool_cocina, 
          prop.c = TRUE, prop.r = TRUE, chisq = TRUE, 
          dnn = c('Usarían nuestra aplicación', 'Cocinas'))     # establecemos las etiquetas de x e y para la tabla y el gráfico
# 3) desconectamos la imagen
dev.off()


# (categorica vs SI,NO,NA)
# Unificamos las categorías "Entre 16 y 17 años" y "Entre 18 y 34 años" de la edad en una nueva variable
#      para que se pueda hacer el test del chi cuadrado
datos$f_Edad_2 <- datos$f_Edad
levels(datos$f_Edad_2) <- list(
  'Jóvenes' = c('De 16 a 17 años', 'De 18 a 34 años'),
  'De 35 a 50' = 'De 35 a 50', 
  'Mas de 50' = 'Mas de 50'
)
# Relación entre la variable del datos$f_Bool_usarias
#        y la variable de datos$f_Edad
#     Esta vez pedimos la tabla sin los porcentajes de fila y columna
crosstab( dep = datos$f_Bool_usarias, 
          indep = datos$f_Edad_2, 
          chisq=TRUE,
          dnn = c('Usarían nuestra aplicación', 'Edad'))
jpeg('grafico usar_app edad.jpg', quality = 100)
crosstab( dep = datos$f_Bool_usarias, 
          indep = datos$f_Edad_2, 
          chisq=TRUE,
          dnn = c('Usarían nuestra aplicación', 'Edad'))
dev.off()

