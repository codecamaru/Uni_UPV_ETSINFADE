package ejemplos.tema3;

import librerias.estructurasDeDatos.modelos.Map;
import librerias.estructurasDeDatos.deDispersion.TablaHash;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

/**
 * Traduccion Bilingue, Palabra a Palabra, de un texto.
 * Dos metodos:
 *  1.- cargarDiccionario: 
 *      del fichero de texto "diccioSpaEng.txt" ubicado en el proyecto eda
 *  2.- traducir: 
 *      traduce la frase textoE palabra a palabra consultando el diccionario d. 
 *      Cuando el diccionario d no contenga 
 *      la traduccion para una palabra de textoE, 
 *      el String resultado de traducir debe contener el literal "<error>"  
 *      en lugar de su traduccion
 */

public class Test5Map {
    
    public static Map<String, String> cargarDiccionario() {
        String nombreDic = "diccioSpaEng.txt";
        Map<String, String> m = new TablaHash<String, String>(100);
        try { 
            Scanner ft = new Scanner(new File(nombreDic), "ISO-8859-1");
            while (ft.hasNextLine()) {
                String linea = ft.nextLine();
                String[] a = linea.split("\t");
                m.insertar(a[0], a[1]);
            }
            ft.close();
            return m;
        } 
        catch (FileNotFoundException e) {
            System.out.println("** Error: No se encuentra el fichero " 
                + nombreDic);
            return null;
        }
    }
    
    public static String traducir(String textoE, Map<String, String> d) {
        //COMPLETAR
        // obtenemos de la cadena en español, un array que contiene una palabra en cada indice
        String[] texto = textoE.split(" +");
        // creamos el StringBuilder para poder apendizar
        StringBuilder s = new StringBuilder();
        // recorremos el array texto
        for(String t : texto){
            // pillo cada palabra del array como clave y la busco en el diccionario
            // obtengo su traduccion
            String ingles = d.recuperar(t); // palabra traducida que hay que añadir al String resultado
            // si no hay una entrada con esa palabra, apendizo en mi resultado error
            if(ingles == null){
                s.append("<error> ");
            }
            // si sí que hay, apendizo mi traducción
            else{
                s.append(ingles);
            }
        }
        // lo paso a String y lo devuelvo
        return s.toString();
    }          
}