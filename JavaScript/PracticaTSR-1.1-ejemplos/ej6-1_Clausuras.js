'use strict'

function f1() {
	console.log ("hola")
}
f1();

let x = "hola"
function f2() {
	console.log (x)
}
f2();


function f3 (arg) {
	let i=0;
	return function () {
		i++;
		console.log (arg + i);
	} 
}

let f = f3 ("hola");
f();
f();
// una clausura es una funcion que retorna otra funcion
/* La función f3() se llama función generadora y la función que retornamos se la
suele llamar función clausura
El soporte a
clausuras de JavaScript mantendrá estas variables en memoria mientras la función clausura esté
referenciada.

*/
