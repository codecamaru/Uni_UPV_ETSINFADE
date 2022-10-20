colhombres = read.csv(file = "colhombres.csv", header=T, sep= ";", dec =",")
View(colhombres)
attach(colhombres)
colmujeres = read.csv(file = "colmujeres.csv", header=T, sep= ";", dec =",")
View(colmujeres)
attach(colmujeres)
alpha = 0.05
#a hombres
t.test(colh, conf.level=1-alpha)$conf.int
summary(colh)
sd(colh)
#b mujeres
t.test(colmujeres, conf.level=0.95)$conf.int
summary(colm)
sd(colm)
#d
qqnorm(colh, datax=TRUE)
qqline(colh,datax=TRUE)
qqnorm(colm,datax=TRUE)
qqline(colm,datax=TRUE)
hist(colh)
boxplot(colh, horizontal = T)
hist(colm)
boxplot(colm, horizontal = T)
#e
t.test(colh, conf.level=0.99)$conf.int
t.test(colm, conf.level=0.99)$conf.int
#f
var.test(colh , colm, conf.level = 0.95 , alt = "two.sided")
t.test(colh , colm , conf.level = 0.95 , alt = "two.sided")
#Ejercicio 2
nasdaq = read.csv(file = "stocks.csv", header=T, sep= ";", dec =",")
View(nasdaq)
attach(nasdaq)
summary(variacion)
sd(variacion)
qqnorm(variacion)
qqline(variacion)
hist(variacion)
boxplot(variacion, horizontal = T)
mean(variacion)
t.test(variacion, conf.level=0.95)$conf.int
#examen
t.test(colh, conf.level=0.9)$conf.int
(165.6300+175.9896)/2
t.test(colmujeres, conf.level=0.95)$conf.int
(174.4456+187.7311)/2
t.test(colh, conf.level=0.95)$conf.int
(164.6190+177.0006)/2
