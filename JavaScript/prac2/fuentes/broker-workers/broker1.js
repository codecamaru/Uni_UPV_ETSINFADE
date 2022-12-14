const {zmq, lineaOrdenes, traza, error, adios, creaPuntoConexion} = require('../tsr')
lineaOrdenes("frontendPort backendPort") // puertoclientes puertobroker
let clientes=[] // peticiones no enviadas a ningun worker
const rout = zmq.socket('router') // clientes
const deal = zmq.socket('dealer') //broker
rout.bind('tcp://*:9000')
deal.bind('tcp://*:9001')

let workDisp = 0

function procesaCliente(cliente,sep,msg){
    traza('procesaCliente','cliente sep msg',[cliente,sep,msg])
    if(workDisp > 0){
        deal.send([cliente,sep,msg])
        workDisp--
    }
    else{
        clientes.push([cliente,msg]) 
    }
}
function procesaBroker(worker,sep1,cliente,sep2,resp){
    traza('procesaBroker','worker sep1 cliente sep2 resp',[worker,sep1,cliente,sep2,resp])
    workDisp++
    if(cliente != ''){
        rout.send([cliente,'',resp])
    }
    if(clientes.length != 0){
        let [c,m] = clientes.shift()
        deal.send([c,'',m])
        workDisp--
    }
}


rout.on('message', procesaCliente)
rout.on('error', (msg) => {error(`${msg}`)})
deal.on('message', procesaBroker)
deal.on('error'  , (msg) => {error(`${msg}`)})
process.on('SIGINT' , adios([rout, deal],"abortado con CTRL-C"))