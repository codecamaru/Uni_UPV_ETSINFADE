function main(y){
	var traza="inicio";
	return f(y);
	
	function f(y){
		var x=100+y;
		
		console.log("\ttraza: ", traza);
		
		return (x%2) ? g0 : g1; debugger

		function g0(){
			traza += "-g0";
			x++;
			console.log("g0: incremento de x:  "+x);
			return f(++y);
			debugger
		}
		
		function g1(){
			traza += "-g1";
			y++;
			console.log("g1: incremento de y:  "+y);
			return f(y);	
			debugger
		}
	}
}


var func = main(-100);
for (let i=0; i<10; i++) {
	debugger
	func = func();
	debugger
}

