#############################
#Instrucciones básicas de R
#############################

#Calculadora
3+5
12+2^3
3*(2+5)
sqrt(16)
log(20)

#Operadores de Asignación
x <- 11
y <- 12
x+y

#También:
x = 14
x

#Y también
y <- 3 -> x
x
y

##Estructuras de datos
#Escalar
x <- 5
x

#Vector
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
x

#Matriz
x2 <- matrix(x, ncol = 2)
x2

x2 <- matrix(x, byrow = TRUE, ncol = 2)
x2

#Clases
class(x)
class(x2)

#Estas estructuras pueden ser de caracteres
x <- "a"
x
x <- "casa"
x

x2 <- matrix(c("a", "b", "c", "d", "e", "f", "g", "h"), ncol = 2)
x2

class(x)
class(x2)

#O lógicas
x <- TRUE

x2 <- matrix(c(TRUE, TRUE, TRUE, FALSE, FALSE, TRUE), ncol=2)

class(x)
class(x2)

#No se pueden juntar. Si se hace se coerciona al tipo más general
c("a", "b", 1, 2)  #Todo a character
c(TRUE, TRUE, 1, 2) #Todo a numeric
c("A", TRUE, 3) #Todo a character

#Estructura más sofisticada: data.frame. Permite combinar columnas de distintos tipos
df <- data.frame(v1 = c("a", "b"), v2 = c(TRUE, FALSE), v3 = c(4, 5))
df
class(df)
class(df$v1)  #character
class(df$v2)  #logical
class(df$v3)  #numeric

#Otras estructuras: Listas
lista <- list("a", TRUE, c(1, 2), data.frame(v1 = c(1, 2, 3), v2 = c("A", "B", "C")))
lista

#Vectorización de operaciones
x <- 10:1
x * 2
x + 1

y <- 1:10

x
y
x + y
x * y
x %*% y  #Como R siempre vectoriza, si queremos el producto escalar, hay que usar la función %*%

#Filtrado (Subsetting)
#En vectores
x

x[1]
x[10]
x[1:4]
x[-(1:4)]
x[c(1, 3, 5, 7, 9)]
x[seq(1, 9, by = 2)]
x[length(x)-1]

#En matrices y data.frame
x2 <- matrix(1:30, ncol=3)
x2

#Filas
x2[1, ]
x2[1, ,drop=FALSE]
x2[1:3, ]

#Columnas
x2[, 2]
x2[, 2, drop=FALSE]

#Filas y columnas
x2[1:4, 2:3]

##Subsetting por expresiones lógicas
x
x[c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)]
x[x > 8]

df
df[df$v3 > 4, ]

#Expresiones lógicas:
x <- 4

#Igualdad
x == 3
x == 4

#Desigualdad
x != 3
x != 4

#Mayor que
x > 8

#Menor que
x < 8

#Mayor o igual que
x >= 4

#Menor o igual que
x <= 4

#Contenido en
x %in% 3
x == 3
x %in% 4
x %in% c(3, 4)
#No confundir con
x == c(3, 4)  #Recordad que R vectoriza siempre que es posible

#Negación
x == 4
x != 4
!x == 4

x <- 10:1
#Combinación de expresiones lógicas
x[x > 2 & x < 8]  #'&': Se tiene que cumplir las dos condiciones
x[x < 2 | x > 8]  #'|': Se cumple una o la otra (o las dos)
x[x < 2 | x %in% c(1, 3, 5)]
x[xor(x < 2, x %in% c(1, 3, 5))] #'xor': Se cumple una o la otra, pero no las dos


##Valor especial:  NA
x <- c(1, 2, 3, 4, NA, 6, 7, 8, 9, 10)
class(x)

x * 2
x + 1
x[x < 2]
x[x > 2]
x[x == 2]
x[x %in% 2]

airquality
airquality[airquality$Ozone > 40,]

#Y si no queremos los NA?
#Para la igualdad se puede sustituir == por %in%
x[x == 4]
x[x %in% 4]

#Para <, >, <= y >=:
#1. Utilizar el paquete clickR y las funciones %>NA% y %<NA%
install.packages("clickR")
library(clickR)
x[x < 2]
x[x %<NA% 2]
x[x %<=NA% 4]
#2. O añadir una segunda condición que filtre los NAs
x[x < 2 & !is.na(x)]

#Comparadores lógicos especiales
is.infinite(c(1/0, log(0), 8))

is.nan(c(log(-1), NA))

is.na(c(log(-1), NA))

is.null(NULL)

is.numeric(x)

is.character("a")

is.logical("TRUE")

is.logical(TRUE)

is.data.frame(df)


#Otras operaciones con vectores, matrices y data.frames
#Combinar vectores en filas o columnas

x <- c(1, 2, 3, 4, 5)
y <- c(6, 7, 8, 9, 10)

x
y
xy <- cbind(x, y)
xy
rbind(x, y)

cbind(xy, y)
rbind(xy, c(9, 9))


#Funciones de control de flujo
#Expresiones if...   else
x <- 3
if(x > 5) print("Hola") else print("Adios")

#Cuidado con la sintaxis
#Esto nos dará error ya que R interpreta que el if() acaba en la linea 248. Por lo que el else no tendría sentido
if(x < 5) print("Hola")
else print("Adiós")

#Si voy a ocupar más de una línea, utilizar {} para marcar inicio y fin
if(x < 5){
  print("Hola")
} else {
  print("Adiós")
}

##Bucles for
p <- 0
for(i in 1:10){
  p <- p + i
}
p

#No suelen ser casi nunca la mejor opción en R
sum(1:10)

for(i in 1:10){
  print(i^2)
}

(1:10)^2


x2

for(i in 1:3) print(mean(x2[,i]))
colMeans(x2)

#Casi siempre se pueden sustituir por funciones de la famila apply
apply(x2, 2, mean)
apply(x2, 1, mean)

##Bucles while
library(numDeriv)
z <- function(x) 3*x^2-2*x-5
x <- 0.5

while(abs(z(x)) >= 0.001){
  x <- x - z(x)/genD(z, x)$D[1]
}

x

#Creación de funciones
#Sumamulti
(2+3)*3
(2+4)*4

sumamulti <- function(x, y){
  (x+y)*y
}
sumamulti(2, 3)
sumamulti(2, 4)

#Recordad que R casi siempre puede vectorizar automáticamente
plot(-10:10, sumamulti(2, -10:10), type="l")
lines(-10:10, sumamulti(3, -10:10))

#Algoritmo de Newtow-Raphson
newton <- function(z, tol=0.001, start=0.5){
  x <- start
  iterations <- 0
  while(abs(z(x)) >= tol){
    x <- x - z(x)/genD(z, x)$D[1]
    iterations <- iterations +1
  }
  return(list(x=x, iterations=iterations))
}

newton(function(x) 3*x^2-2*x-5)
newton(function(x) cos(x)-x^3)


#Importar datos
datos1 <- read.csv2("datos.csv")  #Archivo csv formato españa
datos1

datos2 <- read.csv("datos_eng.csv") #Archivo csv formato americano
datos2