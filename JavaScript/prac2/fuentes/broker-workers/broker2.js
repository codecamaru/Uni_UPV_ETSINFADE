const {zmq, lineaOrdenes, traza, error, adios, creaPuntoConexion} = require('../tsr')
lineaOrdenes("frontendPort backendPort") // puertoworkers puertobroker
let workers  =[] // workers disponibles
const rout = zmq.socket('router') // workers
const deal = zmq.socket('dealer') // broker
rout.bind('tcp://*:9002')
deal.connect('tcp://localhost:9001')

function procesaWorker(worker,sep1,cliente,sep2,resp){
    traza('procesaWorker','worker sep1 cliente sep2 resp',[worker,sep1,cliente,sep2,resp])
    if(cliente == ''){
        workers.push(worker)
        deal.send([worker,'','','',''])
    }
    else if(cliente != ''){
        workers.push(worker)
        deal.send([worker,'',cliente,'',resp])
    }
}
function procesaBroker(cliente,sep,msg){ 
    traza('procesaBroker', 'cliente sep msg',[cliente,sep,msg])
    if (workers.length != 0) rout.send([workers.shift(),'',cliente,'',msg])
}

rout.on('message', procesaWorker)
rout.on('error', (msg) => {error(`${msg}`)})
deal.on('message', procesaBroker)
deal.on('error'  , (msg) => {error(`${msg}`)})
process.on('SIGINT' , adios([rout, deal],"abortado con CTRL-C"))