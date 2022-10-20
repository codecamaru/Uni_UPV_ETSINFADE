nombre = read.csv(file = "nombrearchivo.csv", header=T, sep= ";", dec =",")
View(nombre)
attach(nombre)
mean(x)
median(x)
sd(x)
summary(x)
boxplot(x,horizontal=T,main="Box-Whisker")
quantile(x)
hist(x)
qqnorm(x)
qqline(x)
install.packages("moments")
library(moments)
skewness(x) #CAE [-2 2]
kurtosis(x) # [-2 2]
quantile(x, .15)
t.test(x,conf.level=0.95)$conf.int #IC media
#IC varianza con un alfa 5%
n <-length(x)
numerador <- (n-1)*sd(x)^2
g1 <- qchisq(0.975,df=n-1,lower.tail=F)
g2 <- qchisq(0.025,df=n-1,lower.tail=F)
numerador/g2
numerador/g1
#contraste hipotesis
var.test(pobl1 , pobl2, conf.level = 0.95 , alt = "two.sided") #bilateral
t.test(pobl1 , pobl2 , conf.level = 0.95 , alt = "two.sided") # "less" (pobl1<pobl2), "greater"

sample(1:10,size=10,replace=F)
34.1*2
#P(117<x<123)
pnorm(123,120,2,lower.tail=T)-pnorm(117,120,2,lower.tail=T)
#P(-1.5<x<1.5) tipificado
#P(N(0;1)<1.5)-P(N(0;1)<-1.5)
pnorm(1.5,lower.tail=T)-pnorm(-1.5,lower.tail=T)
#P(N(0;1)<p)=0.05
qnorm(0.05,120,2,lower.tail=T)
#P(N(0;1)>p)=0.05
qnorm(0.05,120,2,lower.tail=F)
#tipificado P(N(0;1)<p)=0.05
qnorm(0.05,lower.tail=T)
#tipificado P(N(0;1)>p)=0.05
qnorm(0.05,lower.tail=F)
#vector datos
c=sample(1:1000,size=500,replace=T)
#X2 Chi-Cuadrado
#P(X^2-11gl>19.675)
pchisq(19.675,df=11,lower.tail=F)
#P(X^2-11gl<3.816)
pchisq(3.816,df=11)
#P(X^2-11gl>x)=0.1
qchisq(0.1,df=11,lower.tail=F)
#P(X^2-11gl<x)=0.1
qchisq(0.1,df=11)
#F-Snedecor
#P(F3,10>3.71)=x
pf(3.71,df1=3,df2=10,lower.tail=F)
#P(F3,10>x)=0.01
qf(0.01,df1=3,df2=10,lower.tail=F)
#P(F3,10<3.71)=x
pf(3.71,df1=3,df2=10) #1-P(F3,10>3.71)
#P(F3,10<x)=0.01
qf(0.01,df1=3,df2=10) #1-0.01=P(F3,10>x) -> qf(0.99,df1=3,df2=10,lower.tail=F)
#t de Student
#P(t10>2.43)
pt(2.43,df=15,lower.tail=F)
#P(t10<1.55)
pt(1.55,df=10)
#P(t20<t)=0.75
qt(0.75,df=20)
#P(t23>t)=0.75
qt(0.75,df=23,lower.tail=F)
hombres=c(175,174,185,182,179)
mujeres=c(177,173,168,175,165)

table(c)
barplot(table(c))
barplot(table(hombres))
barplot(table(sample(1:100, replace=T)))
pie(table(c))
stripchart(hombres,method="stack", pch=16)
plot(hombres)
