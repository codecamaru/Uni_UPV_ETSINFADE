const {zmq, lineaOrdenes, traza, error, adios, creaPuntoConexion} = require('../tsr')
lineaOrdenes("frontendPort backendPort")
let workers  =[] // workers disponibles
let pendiente=[] // peticiones no enviadas a ningun worker
let petTot = 0 // ESTADÍSTICAS
let petw1 = 0
let petw2 = 0
let petw3 = 0
let frontend = zmq.socket('router')
let backend  = zmq.socket('router')
creaPuntoConexion(frontend, frontendPort)
creaPuntoConexion(backend,  backendPort)

function procesaPeticion(cliente,sep,msg) { // llega peticion desde cliente
	traza('procesaPeticion','cliente sep msg',[cliente,sep,msg])
	if (workers.length) backend.send([workers.shift(),'',cliente,'',msg])
	else pendiente.push([cliente,msg])
	petTot++
}
function procesaMsgWorker(worker,sep1,cliente,sep2,resp) {
	traza('procesaMsgWorker','worker sep1 cliente sep2 resp',[worker,sep1,cliente,sep2,resp])
	if (pendiente.length) { // hay trabajos pendientes. Le pasamos el mas antiguo al worker
		let [c,m] = pendiente.shift()
		backend.send([worker,'',c,'',m])
	}
	else workers.push(worker) // añadimos al worker como disponible
	if (cliente) frontend.send([cliente,'',resp]) // habia un cliente esperando esa respuesta
	petTot++
	if(worker == "w1" && cliente != ''){ petw1++ }
	else if(worker == "w2" && cliente != ''){ petw2++ }
	else if(worker == "w3" && cliente != ''){ petw3++ }
}
function muestraEstadisticas(){
	console.log("Número total de peticiones atendidas: "+ petTot)
	console.log("De las cuales atendidas por w1: "+ petw1)
	console.log("De las cuales atendidas por w2: "+ petw2)
	console.log("De las cuales atendidas por w3: "+ petw3)
}
setInterval(muestraEstadisticas, 5000)

frontend.on('message', procesaPeticion)
frontend.on('error'  , (msg) => {error(`${msg}`)})
 backend.on('message', procesaMsgWorker)
 backend.on('error'  , (msg) => {error(`${msg}`)})
 process.on('SIGINT' , adios([frontend, backend],"abortado con CTRL-C"))
