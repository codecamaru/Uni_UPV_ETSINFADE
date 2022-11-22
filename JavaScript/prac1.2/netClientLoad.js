const net = require('net');

args=process.argv.slice(2) // IP Servidor, IP local

const client = net.connect(8000,args[0],
    function() { //connect listener
        console.log('client connected');
        client.write(args[1]);
 });
 
client.on('data',
    function(data) {
        console.log(data.toString());
        //client.end(); //no more data written to the stream
 });
client.on('end',
    function() {
        console.log('client disconnected');
 });
