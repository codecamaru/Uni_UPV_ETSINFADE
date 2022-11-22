const fs = require("fs")

function readFilePromise(nombrearchivo,formato){
    return new Promise( (correcto, fallo) => {
        fs.readFile(nombrearchivo,formato, (err, data) => {
            if(err){ fallo(err+"") }
            else{ correcto(data+"") }
        })
    }
    
    )
}

async function readawait(filename){
    try{
        console.log(await readFilePromise(filename,"utf8"))
    }
    catch(err){
        console.log(err+"")
    }
}
readawait("/etc/hosts")
