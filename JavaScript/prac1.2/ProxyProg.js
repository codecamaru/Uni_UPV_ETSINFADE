const net = require('net');

args=process.argv.slice(2) // REMOTE_IP, REMOTE_PORT

const LOCAL_PORT = 8000;
const LOCAL_IP = '127.0.0.1';
var REMOTE_PORT = 80;//args[1];
var REMOTE_IP = "158.42.4.23";//args[0]; // www.upv.es

const server = net.createServer(function (socket) {
 const serviceSocket = new net.Socket();
 serviceSocket.connect(parseInt(REMOTE_PORT),
 REMOTE_IP, function () {
                socket.on('data', function (msg) {
                                    serviceSocket.write(msg);
                                   });
                serviceSocket.on('data', function (data) {
                                            socket.write(data);
                                        });
        });
}).listen(LOCAL_PORT, LOCAL_IP);
const server2 = net.createServer(
    function(c) { //connection listener
        console.log('server: client connected');
        c.on('end', function() {
                    console.log('server: programador disconnected');
                    });
        c.on('data', function(data) {
                    let obj = JSON.parse(data);
                    REMOTE_PORT = obj.RemotePort;
                    REMOTE_IP = obj.RemoteIP;
                    console.log('The configuration of the proxy changed')
                    c.end(); // close socket
                    });
        });
server2.listen(8001, function() { //listening listener
                    console.log('server bound');
            });

console.log("TCP server accepting connection on port: " + LOCAL_PORT);
