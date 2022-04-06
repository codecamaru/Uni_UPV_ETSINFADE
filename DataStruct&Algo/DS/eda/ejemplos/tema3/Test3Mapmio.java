package ejemplos.tema3;

//para poder usar Map y ListaConPI
import librerias.estructurasDeDatos.modelos.*; 

//para poder usar TablaHash, la Implementacion de Map
import librerias.estructurasDeDatos.deDispersion.*; 

// CUESTION: ?Que sucede si, en lugar de los dos import, 
// se escribe: import java.util.*;?
import java.util.Locale; 
import java.util.Scanner; 

public class Test3Mapmio {
    
    public static void main(String[] args) {
        
        // Por simplicidad, la frase no se lee de un fichero,  
        // sino que se lee de teclado como un String de Palabras 
        // separadas por blancos. Una frase (String) ejemplo seria: 
        // "vale, aunque es un poco rollo lo hago para que se vea como funciona el Map!! Se me ha olvidado escribir palabras repetidas vaya!!"

        // Lectura de la frase (String) a partir de la que se construye el Map
        Locale localEDA = new Locale("es", "US");
        Scanner teclado = new Scanner(System.in).useLocale(localEDA);
        System.out.println("Escriba palabras separadas por blancos:");
        String texto = teclado.nextLine();

        String[] palabrasDelTexto = texto.split(" +");

        Map<String, Integer> m = new TablaHash<String, Integer>(palabrasDelTexto.length);

        for (int i = 0; i < palabrasDelTexto.length; i++){ 
            String palabra = palabrasDelTexto[i].toLowerCase();
            Integer cont = m.recuperar(palabra);
            if(cont == null){
                m.insertar(palabra,1);
            }
            else{
                m.insertar(palabra,1 + cont);
            }
             
        }
        
        ListaConPI<String> deClaves = m.claves();
        System.out.println("\n Palabras del texto que se han repetido: \n");
        ListaConPI<String> listaConRep = new LEGListaConPI<String>();
        for(deClaves.inicio(); !deClaves.esFin(); deClaves.siguiente()){
            String palabra = deClaves.recuperar();
            int cont = m.recuperar();
            if(cont > 1){
                listaConRep.insertar("(" + palabra + ", " + cont + ")");
            }
        }
        System.out.println(listaConRep);
    } 
}