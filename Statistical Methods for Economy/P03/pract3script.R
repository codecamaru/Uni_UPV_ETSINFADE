sample(1:5,size=15, replace=TRUE) # muestreo con reemplazamiento
sample(1:40,size=15, replace=TRUE) # muestreo con reemplazamiento
sample(1:25,size=15, replace=TRUE) # muestreo con reemplazamiento
consumo = c(430,396,414,416,432,368,360,371,416,341,416,349,409,488,267)
mean(consumo)
median(consumo)            
sd(consumo)
boxplot(consumo,horizontal=T,main="Diagrama de caja")
qqnorm(consumo)
qqline(consumo)
hist(consumo)
otras_muestras = read.csv(file = "Otras_Muestras_Consumo.csv", header=T, sep= ";", dec =",")
View(otras_muestras)
attach(otras_muestras)
mean(otras_muestras$Muestra1)
mean(otras_muestras$Muestra2)
mean(otras_muestras$Muestra3)
mean(otras_muestras$Muestra4)
mean(otras_muestras$Muestra5)
sd(otras_muestras$Muestra1)
sd(otras_muestras$Muestra2)
sd(otras_muestras$Muestra3)
sd(otras_muestras$Muestra4)
sd(otras_muestras$Muestra5)
t.test(consumo,conf.level=0.95)$conf.int
# intervalo de confianza para la varianza
n <- length(consumo)
numerador <- (n-1)*sd(consumo)^2
g1 <- qchisq(0.975,n-1,lower.tail=F)
g2 <- qchisq(0.25,n-1,lower.tail=F)
numerador/g2
numerador/g1
sqrt(numerador/g2)
sqrt(numerador/g1)
n <- length(otras_muestras)
numerador <- (n-1)*sd(otras_muestras$Muestra5)^2
g1 <- qchisq(0.975,n-1,lower.tail=F)
g2 <- qchisq(0.25,n-1,lower.tail=F)
numerador/g2
numerador/g1
sqrt(numerador/g2)
sqrt(numerador/g1)
t.test(otras_muestras$Muestra4,conf.level=0.95)$conf.int
402.2117-356.3268
