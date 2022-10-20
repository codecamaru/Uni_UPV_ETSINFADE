#Ejer 1
#hombres dieta
antes = c(75.3, 76.5, 82.1, 65.4, 63.7, 78.6, 74.2, 77.3, 70.5, 66.9, 85.6, 66.3, 65.1, 68.2)
despues = c(73.2, 76.2, 80.4, 65.5, 64.0, 75.5, 71.6, 75.8, 69.1, 63.8, 86.0, 67.1, 64.5, 62.0)
mean(antes)
sd(antes)
summary(antes)
hist(antes)
boxplot(antes,horizontal=T)
qqnorm(antes)
qqline(antes)
mean(despues)
sd(despues)
summary(despues)
hist(despues)
boxplot(despues,horizontal=T)
qqnorm(despues)
qqline(despues)
#IC al 95%
t.test(antes-despues,conf.level=0.95)$conf.int
#contraste hipotesis medias mediante contraste parametrico
t.test(x=antes, y=despues, mu=0, alternative="greater",paired=T, conf.level = 0.95)
#test de Wilcoxon
wilcox.test(x=antes, y=despues, mu=0, alternative = "greater", conf.level=0.95, paired = TRUE)
#Ejer 2
nA = c(280, 222, 217, 331, 181, 203, 223, 199, 220, 149, 197)
nB = c(180, 222, 200, 220, 220, 290, 200, 245, 283, 391, 211)
mean(nA)
sd(nA)
summary(nA)
hist(nA)
boxplot(nA,horizontal=T)
qqnorm(nA)
qqline(nA)
mean(nB)
sd(nB)
summary(nB)
hist(nB)
boxplot(nB,horizontal=T)
qqnorm(nB)
qqline(nB)
#Wilcoxon no apareado
wilcox.test(x=nA, y=nB, mu=0, alternative = "two.sided", conf.level=0.95, paired =FALSE)
wilcox.test(x=nA, y=nB, mu=0, alternative = "two.sided", conf.level=0.95, paired =TRUE)
