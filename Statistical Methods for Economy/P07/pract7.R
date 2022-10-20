# Ejercicio 1
# (a) Identifique la variable respuesta y las variables independientes consideradas en este estudio:
# Variable respuesta: el incremento de las ventas de patinetes en miles de euros
# Variables independientes: gastos mensuales en miles de euros de la publicidad en TV, 
# gastos mensuales en miles de euros de la publicidad en la radio y 
#  gastos mensuales en miles de euros de la publicidad en periódicos (RECOGIAS DURANTE LOS ÚLTIMOS 24 MESES)
# LA MUESTRA OBTENIDA POR M.A.S. SE SUPONE REPRESENTATIVA DE LA POBLACIÓN
library(readxl)
patinete <- read_xlsx("patinete.xlsx")
View(patinete)
attach(patinete)
# (b) Obtener un diagrama de dispersión para las ventas y cada una de las variables de gasto en publicidad.
# ¿Hay alguna relación que parezca más lineal? ¿Por qué?
plot(Pub_tv~Ventas)
plot(Pub_radio~Ventas)
plot(Pub_periodico~Ventas)
# La única relación que parece más lineal es la que hay entre el gasto en publicidad en el periódico y las ventas, 
# porque la nube de puntos obtenida se aproxima a una recta en la diagonal del gráfico
# (c) Obtenga el coeficiente de correlación lineal. ¿Se confirma la mayor relación lineal entre Ventas y la variable 
# que detectaste en el apartado b)?
cor(Pub_tv,Ventas) # 0.1002119 relación positiva débil
cor(Pub_radio,Ventas) # -0.2482262 relación negativa débil
cor(Pub_periodico,Ventas) # 0.8880548 relación positiva razonadamente fuerte (se aproxima más a 1)
# (d) Obtenga el modelo de regresión lineal simple entre la variable Ventas y la publicidad seleccionada en el apartado c) 
# e interprete su valor:
modelo<-lm( Ventas ~Pub_periodico)
summary(modelo)
# Pendiente: 0.15058
# Término independiente: 5.08400
# Escribe el modelo de regresión lineal simple obtenido:
# Modelo: /Y = 5.084 + 0.15058X
# (e) A partir del test F (ANOVA) (última línea del modelo obtenido en el apartado anterior).
# Hipótesis del test:
#  𝐻0: beta = 0
#  𝐻1: beta distinto de 0
# Valor del estadístico 𝐹: 82.09
# Grados de libertad del modelo: 1
# Grado de libertad residuales: 22
# Valor 𝑝: (con 4 cifras decimales de precisión) 7.044e-09 = 0,000000007044
# Explique sus conclusiones en el contexto del problema:

# Al haber obtenido un valor p tan pequeño, tenemos suficiente evidencia desde el punto de vista estadístico
# para rechazar la Ho y suponer que el modelo planteado es válido, que la variable independiente "Gasto de publicidad en el periodico"
# me ayuda a explicar la variable dependiente " incremento en las Ventas del patinete"

# Interprete el valor de R2 en el contexto del problema: Multiple R-squared:  0.7886
# Este valor nos informa del porcentaje de variabilidad del incremento en las ventas de patinete que viene explicado por 
# la variable "Gasto de publicidad periodico" a través del modelo propuesto. Como es un porcentaje alto (78.86%), sabemos que 
# nuestro modelo ayuda en buena medida a explicar el incremento en las ventas. El porcentaje restante vendrá explicado por otras 
# variables. 
# (f) Utiliza los residuos (R los almacena en la variable modelo$residuals) para validar el modelo (es decir, para comprobar 
# el cumplimiento de las tres condiciones asumidas en realizar la regresión):
# 1. Independencia (entre las observaciones). Esta condición debe garantizar la
# forma en que se seleccionan los individuos (utilizando un muestreo probabilístico o un diseño aleatorizado). 
# La muestra es aleatoria, por lo que asumimos que se cumple.
plot(Mes, residuals(modelo)) # vemos que no se cumple 
# 2. Normalidad. Compruebe si es aceptable pensar que los residuos proceden de una población normal de media igual a cero.
summary(residuals(modelo))
boxplot(residuals(modelo), horizontal=TRUE)
hist(residuals(modelo))
qqnorm(residuals(modelo))
qqline(residuals(modelo))
# La media es igual a 0 y como en el gráfico de cuantiles la nube de puntos se aproxima a una recta, podríamos suponer normalidad. (hay dudas)
# 3. Homoscedasticidad (Igualdad de varianzas). Compruebe si la dispersión de los residuos es similar en los todos los 
# valores de la variable ajustada. Con este gráfico se comprueba que la variabilidad es más o menos similar.
plot(residuals(modelo),Ventas) # no se cumple 
#Después de estos análisis, ¿cree que el modelo de regresión simple es un modelo válido para predecir el incremento en ventas?
# no es un modelo válido porque no cumplimos ni independencia ni homoscedasticidad
fm=aov(Ventas~Pub_periodico)
summary(fm)
cbind(fm$residuals,residuals(modelo))

# Ejercicio 2: Introducción a la regresión lineal múltiple
# Obtenga el modelo de regresión lineal múltiple entre la variable Ventas y los gastos en publicidad.
modelo2<-lm( Ventas ~ Pub_tv+Pub_radio+Pub_periodico)
summary(modelo2)
# (a) ¿Qué variables no son significativas? ¿Por qué?
# Observamos en primer lugar que la variable independiente con un pvalue más alto (0.93179) son los gastos en publicidad de la TV, por tanto no 
# hemos encontrado evidencias suficientes para suponer que beta de la Pub_tv es distinto de cero, no podemos rechazar, lo que significa
# que esta variable no me ayuda a explicar el comportamiento de las ventas. De la misma forma, también podríamos decir que Pub_radio
# no es explicativa, pues su pvalue 0.15962 es mayor que cualquier alfa.
# Elimina (una a una) las variables que no sean significativas.
modelo3<-lm( Ventas ~ Pub_radio+Pub_periodico)
summary(modelo3)
modelo4<-lm( Ventas ~ Pub_periodico)
summary(modelo4)
# (b) Escribe el modelo resultante: /Y = 8.66663 - 0.04778GastoPubl.Radio + 0.14779GastoPubl.Periodico
# El anterior código también te muestra el valor del estadístico F (ANOVA) en R para validar el modelo según el test 
# de significación global.
# Hipótesis del test:
# 𝐻0: Beta1=Beta2=0
# 𝐻1: alguna beta es distinta de cero
# Valor del estadístico 𝐹: 45.62
# Grados de libertad del modelo: 2
# Grados de libertad residuales: 21
# Valor 𝑝: 2.273e-08 = 0.00000002273
# Explique sus conclusiones en el contexto del problema: Como el pvalue del modelo es menor a cualquier alfa, hemos encontrado 
# evidencias suficientes para suponer que el modelo propuesto explica el comportamiento de las ventas. Además, la bondad de ajuste
# es 81.29%, lo que indica que el modelo explica el 81.29% de la variabilidad del incremento medio de las ventas.
# Como el pvalue de la variable Pub_radio es mayor a cualquier alfa, podríamos eliminar esta variable del modelo , ya que no habríamos
# encontrado suficientes evidencias para suponer que Betapublicidad es distinto de cero y por lo tanto no podemos suponer que esta es una 
# variable explicativa del incremento medio mensual en las ventas. 

# Interprete el valor de R2 en el contexto del problema: la bondad de ajuste
# es 81.29%, lo que indica que el modelo explica el 81.29% de la variabilidad del incremento medio de las ventas, 
# el  18.71% restante viene explicado por otras variables mediante otros modelos. Como es un porcentaje alto, es un modelo válido.












