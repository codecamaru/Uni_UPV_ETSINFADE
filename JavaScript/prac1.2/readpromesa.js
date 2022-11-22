const fs = require('fs')

function readFilePromise(nombrearchivo,formato){
    return new Promise( (correcto, fallo) => {
        fs.readFile(nombrearchivo,formato, (err, data) => {
            if(err){ fallo(err+"") }
            else{ correcto(data+"") }
        })
    }
    
    )
}
readFilePromise("/etc/hosts","utf8").then(console.log,console.log)
