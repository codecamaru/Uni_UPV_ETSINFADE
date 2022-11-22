const net = require('net');

args=process.argv.slice(2) // IP Proxy, nueva IP Servidor, nuevo puerto Servidor

var objjson = {"RemoteIP":"158.42.186.55","RemotePort":8080}; // memex.dsic.upv.es

const client = net.connect(8001,args[0],
    function() { //connect listener
        console.log('client connected');
        client.write(JSON.stringify(objjson));
        client.end(); //no more data written to the stream
 });
 
client.on('end',
    function() {
        console.log('client disconnected');
 });
