const {zmq, error, lineaOrdenes, traza, adios, creaPuntoConexion} = require('../tsr')
const pub = zmq.socket('pub')

argumentos = process.argv.slice(2)
port = argumentos[0]
numMensajes = argumentos[1]
let temas = argumentos.slice(2)

pub.bindSync("tcp://*:"+port+"")

function envia(tema, numMensaje, ronda) {
    console.log(tema, numMensaje+1, ronda+1)
	pub.send([tema, numMensaje, ronda]) 
}
function publica(i) {
	return () => {
		envia(temas[i%temas.length], i, Math.trunc(i/temas.length))
		if (i==(numMensajes-1)) adios([pub],"")()
		else setTimeout(publica(i+1),1000)
	}
}
setTimeout(publica(0), 1000)

pub.on('error', (msg) => {error(`${msg}`)})
process.on('SIGINT', adios([pub],"abortado con CTRL-C"))