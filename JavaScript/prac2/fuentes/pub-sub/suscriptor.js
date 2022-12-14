const {zmq, lineaOrdenes, traza, error, adios, conecta} = require('../tsr')
lineaOrdenes("identidad ipPublicador portPublicador tema")

let sub = zmq.socket('sub')
sub.subscribe(tema)
conecta(sub, ipPublicador, portPublicador)


function recibeMensaje(tema, numero, ronda) {
	clearInterval(t2)
    traza('recibeMensaje','tema numero ronda',[tema, numero, ronda])
    t2 = setTimeout(adios([sub],"Hace mucho que no me envían mensajes. Adios"),20000)
}

    sub.on('message', recibeMensaje)
    sub.on('error'  , (msg) => {error(`${msg}`)})
process.on('SIGINT' , adios([sub],"abortado con CTRL-C"))
var t2 = setTimeout(adios([sub],"Hace mucho que no me envían mensajes. Adios"),20000)