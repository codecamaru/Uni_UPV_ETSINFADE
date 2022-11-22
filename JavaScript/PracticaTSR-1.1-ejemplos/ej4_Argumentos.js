'use strict'

function f1 (a,b,c) {
	console.log ("recibo " + arguments.length + " argumentos")
	return a+b+c;
}

let result1 = f1 (1,2,3)
let result2 = f1 (1,2,3,4,5,6)
let result3 = f1 (1)

console.log ("result1: " + result1)
console.log ("result2: " + result2)
console.log ("result3: " + result3)

let vector = [1,2,3,4]

console.log ("resultv1: " + f1 (...vector))
console.log ("resultv2: " + f1 (vector))
/* arguments is an Array-like object accessible inside functions that contains the values of the arguments passed to that function.
Los puntos suspensivos ...vector es como que avisan a la funcion que le pasas un vector y entonces arguments ahora sería ese vector, por tanto te dice el numero de elementos de ese vector. Notese que si dentro del vector le pones más vectores anidados, solo te contará elementos del vector más grande
*/
