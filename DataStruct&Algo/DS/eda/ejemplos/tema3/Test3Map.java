package ejemplos.tema3;

// para poder usar Map y ListaConPI: 
import librerias.estructurasDeDatos.modelos.*; 

// para poder usar TablaHash, la Implementacion de Map: 
import librerias.estructurasDeDatos.deDispersion.*; 

// CUESTION: ?Que sucede si, en lugar de los dos import, 
// se escribe: import java.util.*;?
import java.util.Locale; 
import java.util.Scanner; 
                                                   
public class Test3Map {    
    public static void main(String[] args) {        
        /** Por simplicidad, la frase no se lee de un fichero,  
         *  sino que se lee de teclado como un String de Palabras 
         *  separadas por blancos. Una frase (String) ejemplo seria: 
         *  "Las cosas son como son aunque esas cosas no sean siempre las mismas cosas"
         * 
         *  lectura de la frase (String) a partir de la que se construye el Map
         */
        Locale localEDA = new Locale("es", "US");
        Scanner teclado = new Scanner(System.in).useLocale(localEDA);
        System.out.println("Escriba palabras separadas por blancos:");
        String texto = teclado.nextLine();

        /** uso del metodo split de String con separador " " (uno o mas) */
        String[] palabrasDelTexto = texto.split(" +");
        
        /** Creacion del Map vacio */
        Map<String, Integer> m = 
            new TablaHash<String, Integer>(palabrasDelTexto.length);

        /** Construcción del Map, 
         *  via insercion/actualizacion de sus Entradas, 
         *  a partir de la frase leida
         */            
        for (int i = 0; i < palabrasDelTexto.length; i++) {
            String palabra = palabrasDelTexto[i].toLowerCase();
            Integer contador = m.recuperar(palabra);
            if (contador == null) m.insertar(palabra, 1);
            else                  m.insertar(palabra, contador + 1);
        }
        
        /** Listado de las Entradas del Map 
         *  que correspondan a palabras repetidas,
         *  mediante recorrido de la ListaConPI de las claves del Map, 
         *  recuperar sus valores, y mostrar las Entradas donde valor sea >= 2
         */
        System.out.println("\nListado de las palabras repetidas en el texto:");
        ListaConPI<String> deClaves = m.claves();        
        deClaves.inicio();
        while ( !deClaves.esFin() ) {
            String palabra = deClaves.recuperar();
            Integer contador = m.recuperar(palabra);
            if (contador >= 2) {
                System.out.println("(" + palabra + ", " + contador + ")");
            }
            deClaves.siguiente();
        }
    } 
}