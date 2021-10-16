package aplicaciones.primitiva;

import librerias.estructurasDeDatos.modelos.ListaConPI;
import librerias.estructurasDeDatos.lineales.LEGListaConPI;
import librerias.estructurasDeDatos.lineales.LEGListaConPIOrdenada;

/** 
 * ApuestaPrimitiva: representa una apuesta aleatoria de La Primitiva, 
 * o combinacion de 6 numeros distintos entre el 1 y el 49 elegidos  
 * de forma aleatoria.
 * 
 * @version Febrero 2019
 */

public class ApuestaPrimitiva {
    
    // Una Primitiva TIENE UNA Lista con PI que almacena
    // una combinacion de 6 numeros de La Primitiva
    private ListaConPI<NumeroPrimitiva> combinacion;
    
    /**
     * Crea una ApuestaPrimitiva, o una combinacion de  
     * seis numeros aleatorios con valores distintos y   
     * en el intervalo [1, 49].
     * 
     * @param ordenada Un boolean que indica si la combinacion,  
     *                 sus 6 numeros, debe estar ordenada Asc.
     *                 (true) o no (false).           
     */
    public ApuestaPrimitiva(boolean ordenada) {
        if(ordenada == true){
         combinacion = new LEGListaConPIOrdenada<>();
         for(int i = 0; i < 6 ; i++){
             NumeroPrimitiva e = new NumeroPrimitiva();
             if(posicionDe(e) == -1){
                combinacion.insertar(e);
             }else{ i--; }
         }
        }
        else{
         combinacion = new  LEGListaConPI<>();
         for(int i = 0; i < 6 ; i++){
             NumeroPrimitiva e = new NumeroPrimitiva();
             if(posicionDe(e) == -1){
                combinacion.insertar(e);
             }else{ i--; }
         }
        }
    }
    
    /**
     * Devuelve la posicion del numero n en una ApuestaPrimitiva, 
     * o -1 si n no forma parte de la combinacion. 
     * IMPORTANTE: se asume que el primer elemento de una combinacion 
     * esta en su posicion 0 y el ultimo en la 5.
     * 
     * @param n un int
     * @return  la posicion de n en una combinacion, un valor int
     *          en el intervalo [0, 5] si n esta en la combinacion      
     *          o -1 en caso contrario
     */
    protected int posicionDe(NumeroPrimitiva n) {
        combinacion.inicio();
        int i = 0;
        while(!combinacion.esFin()) {
            if((combinacion.recuperar()).equals(n)){ return i;}
            else{ combinacion.siguiente(); i++;}
        }
        return -1; 
    }
    
    
    /**
     * Devuelve el String que representa una ApuestaPrimitiva en el formato
     * texto que muestra el siguiente ejemplo: "16, 25, 28, 49, 9, 20"
     * 
     * @return el String con la ApuestaPrimitiva en el formato texto dado. 
     */
    public String toString() {
        combinacion.inicio();
        String str = (combinacion.recuperar()).toString();
        for(int i = 1; i < 6; i++){
            combinacion.siguiente();
            str += ", " + (combinacion.recuperar()).toString();
        }
        return str;
    }
}
