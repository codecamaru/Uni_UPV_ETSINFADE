'use strict'

class Animal {
	nombre; // declarar los atributos es opcional
	constructor (nombre) {
		this.nombre = nombre;
	}
	habla() {}
	nombreAnimal() {return this.nombre}
}

class Perro extends Animal {
	constructor () {
		super ("perro");
	}
	habla() {return "guau"}
}

let perro = new Perro();
console.log (perro.nombreAnimal() + " dice " + perro.habla())
