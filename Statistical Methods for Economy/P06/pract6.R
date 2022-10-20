# EJERCICIO 1
# (a) Identifique la variable respuesta y el factor considerados en este estudio:
# Variable respuesta: Tiempo que los clientes están en la pizzería
# Factor: Tipo de Aroma que se ha colocado en la pizzería. 3 niveles. Factor cualitativo.
# Identifique también las muestras y las poblaciones de este estudio:
# Muestras: Muestra 1: clientes que han pasado la tarde el sábado en que se han tomado los datos con aroma lavanda, Muestra 2: clientes
# que han pasado la tarde del sábado que se ha puesto el aroma limón, y Muestra 3: clientes "" sin aroma (grupo control)
# Poblaciones: Población 1: clientes que pasan la tarde los sábados con aroma lavanda, lo mismo con aroma limón y lo mismo sin aroma
#
# Una única columna con todos los datos de los tres grupos:
tiempo = c(92 , 126 , 114 , 106 , 89 , 137 , 93 , 76 , 98 , 108 ,
           124 , 105 , 129 , 103 , 107 , 109 , 94 , 105 , 102 , 
           108 , 95 , 121 , 109 , 104 , 116 , 88 , 109 , 97 , 101 , 
           106 , 78 , 104 , 74 , 75 , 112 , 88 , 105 , 97 , 101 , 89 ,
           88 , 73 , 94 , 63 , 83 , 108 , 91 , 88 , 83 , 106 ,
           108 , 60 , 96 , 94 , 56 , 90 , 113 , 97 ,
           103 , 68 , 79 , 106 , 72 , 121 , 92 , 84 , 72 , 92 ,
           85 , 69 , 73 , 87 , 109 , 115 , 91 , 84 , 76 , 96 ,
           107 , 98 , 92 , 107 , 93 , 118 , 87 , 101 , 75 , 86)
# Una columna que indica a que aroma pertenece cada tiempo:
aroma = rep(c("lavanda" , "limón" , "sin aroma") , c(30 , 28 , 30))
# Convertimos la columna `aroma` en factor:
aroma = factor(aroma)

# (b) Obtener un diagrama de caja múltiple para el tiempo de permanencia de los
# clientes en función del aroma del restaurante. ¿Alguna distribución presenta
# valores aislados? ¿Alguna distribución presenta una asimetría muy marcada?
boxplot(tiempo~aroma, horizontal = TRUE)
# La distribución de la muestra "lavanda" presenta valores aislados, superiores e inferiores. La distribución "limón" presenta 
# una asimetría negativa muy marcada. 
skewness(tiempo[aroma == "sin aroma"]) 
skewness(tiempo[aroma == "lavanda"]) 
skewness(tiempo[aroma == "limón"]) 

# (c) Obtenga un gráfico en papel probabilístico normal para cada grupo. ¿Podemos
# asumir que las distribuciones son normales?
qqnorm(tiempo[aroma == "lavanda"] , datax = TRUE)
qqline(tiempo[aroma == "lavanda"] , datax = TRUE)
qqnorm(tiempo[aroma == "limón"] , datax = TRUE)
qqline(tiempo[aroma == "limón"] , datax = TRUE)
qqnorm(tiempo[aroma == "sin aroma"] , datax = TRUE)
qqline(tiempo[aroma == "sin aroma"] , datax = TRUE)
# Yo diría que difícilmente podemos asumir que son normales, como mucho la de limon y la de sin aroma

# (d) Realice un test F (ANOVA) en R para comparar las medias de las tres poblaciones.
# Hipótesis del test:
# 𝐻0: "El tiempo medio que pasan los clientes los sábados por la tarde en la pizzería con aroma lavanda es el mismo 
# que con aroma limón y sin aroma"
# 𝐻1: "al menos uno de los tiempos medios no coincide" 
fm = aov(lm(tiempo~aroma))
summary(fm)
# Valor de el estadístico 𝐹: 10.86
# Grados de libertad del factor: 2
# Grados de libertad residuales: 85
# Valor 𝑝: 6.3e-05= 6.3 x 10^-5 = 0.000063
# Explique sus conclusiones en el contexto del problema: el valor de p es realmente pequeño para cualquier alfa, 
# por lo que debemos rechazar la hipótesis nula, pues tenemos evidencia suficiente para suponer que las medias de 
# los tiempos no coinciden. Los resultados son estadísticamente significativos. Existe evidencia suficiente para pensar
# que el aroma del ambientador tiene un efecto significativo sobre el tiempo que permanece un cliente en tienda con un 
# nivel de significación del 5%

# (e) Obtenga un gráfico de los intervalos HSD de Tukey del análisis anterior.
intervals = TukeyHSD(fm)
plot(intervals)
# ¿Qué conclusión se puede extraer de estos intervalos? Como el 0 cae dentro del intervalo sin aroma-limón, podemos suponer que en 
# algún momento los tiempos medios serán iguales, y como sin aroma-lavanda y limón-lavanda no contienen el 0, no podemos suponer que 
# sean iguales. Como los dos anteriores contienen valores negativos, podemos suponer que los tiempos medios de lavanda son mayores que 
# los de limón y que los de sin aroma. 

# (f) 
# 1. Independencia (entre y dentro de las muestras). Esta condición debe garantizar la forma en que se seleccionan los individuos 
# (utilizando un muestreo probabilístico o un diseño aleatorizado).
plot(fm$residuals) # Vemos que se cumple porque se observa una dispersión aleatoria de los puntos, que no sigue un patrón
# en el eje de la Y: lo observado menos lo estimado, con lo cual puede ser negativo. En el eje X, el orden con el que voy tomando 
# muestra; como hay 88 valores, va hasta casi el 90 en el gráfico.
# 2. Normalidad. Compruebe si es aceptable pensar que los residuos proceden de una población normal de media igual a cero.
summary(fm$residuals) # media sí es = 0
boxplot(fm$residuals, horizontal=T) # No hay demasiada asimetría 
hist(fm$residuals) # histograma con forma de campana
qqnorm(fm$residuals , datax = TRUE)
qqline(fm$residuals , datax = TRUE) # Es aceptable pensar que hay normalidad en la población de los residuos
# 3. Homoscedasticidad (Igualdad de varianzas). Compruebe si la dispersión de los residuos es similar en los tres grupos. 
# Puede utilizar un diagrama de caja múltiple y también el contraste de hipótesis con los residuos al cuadrado.
boxplot(fm$residuals~aroma)
# ANOVA residuos al cuadrado
res2=aov(lm(fm$residuals^2~aroma))
summary(res2) # como me ha salido un Pvalue muy alto para cualquier alfa y mi Ho era que las varianzas residuales eran las mismas,
#no puedo rechazar que las varianzas son iguales, es estadísticamente significativo. Por tanto, puedo aceptar que hay homocedasticidad.
# Después de estos análisis, ¿cree que el ANOVA es un modelo válido para estos datos? Lo es, ya que se cumplen todas las condiciones.

# Ejercicio 2
library(readxl)
female_inc <- read_excel("female.inc.xlsx")
View(female_inc)
attach(female_inc)
# (a) ¿Cuántas mujeres hay en la muestra? 1000 ¿Cuántos grupos étnicos hay? 3: black, hispanic, white 
# ¿Cuántas mujeres hay en cada grupo? black: 122, hispanic: 93, white: 785
length(race)
table(race)

# (b) Realice un análisis descriptivo de los ingresos ( 'income'). 
# ¿Crees que esta variable sigue un modelo de distribución normal? ¿Por qué?
mean(income)
median(income)
sd(income)
summary(income)
boxplot(income, horizontal=T, main="Box-Whisker")
quantile(income)
hist(income)
qqnorm(income)
qqline(income)
# Esta variable no sigue un modelo de distribución normal para nada, hay una asimetría positiva bestial, causada por los tan elevados
# outliers superiores.

# (c) A veces, una transformación de la variable respuesta permite aplicar técnicas paramétricas. 
# Si utilizamos el logaritmo de los ingresos (log(income)como variable respuesta, ¿podemos utilizar un ANOVA con estos datos?)
log_inc = log(income)
qqnorm(log_inc)
qqline(log_inc)
hist(log_inc)
plot(log_inc)
#Obtener la tabla resumen del ANOVA de log (income) con el factor race. ¿Existen
# diferencias significativas entre los ingresos medios de los diferentes grupos étnicos?
fn = aov(lm(log_inc~race))
summary(fn) # como pvalue es muy pequeño (0.000964), existen diferencias significativas entre 
# los ingresos medios de los diferentes grupos étnicos de mujeres
plot(fn$residuals) # independencia residuos
boxplot(fn$residuals, horizontal = T) # muy poca asimetria en residuos
qqnorm(fn$residuals)
qqline(fn$residuals) # no obstante no podemos asumir normalidad, mejor usar otro método
library("moments")
skewness(fn$residuals) #entre -2 y 2

# (d) Obtenga un gráfico para los intervalos HSD de Tukey. Explique sus conclusiones:
intervalos = TukeyHSD(fn)
plot(intervalos)
# podemos suponer white-black mismo salario medio, black tiene mayor salario medio que hispanic, y white tiene mayor salario 
# medio que hispanic (pero tampoco por mucho) 

# (e) Compruebe si se cumplen las condiciones para utilizar la técnica del ANOVA mediante un análisis de los residuos:
#  1. Independencia. Asumimos que los datos se obtuvieron mediante un muestreo probabilístico (no hay que hacer nada)
plot(fn$residuals) # Sí que hay independencia
#  2. Normalidad. Realice los análisis necesarios para comprobarla. ¿Podemos asumir que se cumple? ¿por qué?
summary(fn$residuals) # media 0
boxplot(fn$residuals, horizontal=T)
hist(fn$residuals)
qqnorm(fn$residuals , datax = TRUE)
qqline(fn$residuals , datax = TRUE) # NO se cumple normalidad
#  3. Homoscedasticidad. Realice los análisis necesarios para comprobarla. ¿Podemos asumir que se cumple? ¿Por qué?
boxplot(fn$residuals~race)
res2=aov(lm(fn$residuals^2~race))
summary(res2) # podríamos decir que sí hay homocedasticidad ya que la Ho es que las varianzas son iguales y el pvalue es alto, 0.224
# por tanto no puedo rechazar que sean iguales

# (f) Si no se cumplen las condiciones, utilice una prueba no paramétrica para poder obtener conclusiones válidas 
kruskal.test(income~race)
# Valor 𝑝:0.002748
# Conclusión: existen diferencias significativas entre los salarios medios de los grupos étnicos
# ¿Se obtiene la misma conclusión que con la técnica del ANOVA? Sí








