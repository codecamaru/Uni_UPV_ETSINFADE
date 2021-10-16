package librerias.estructurasDeDatos.lineales;

/** Clase friendly que representa un Nodo de una LEG
 *  TIENE UN:
 *  - dato, el elemento que contiene el Nodo
 *  - siguiente, la referencia al siguiente Nodo de la LEG
 *  
 */

class NodoLEG<E> {

    E dato;
    NodoLEG<E> siguiente;
   
    /** Crea un Nodo que contiene al Elemento e y al que sigue el Nodo s 
     *  @param e Elemento que contiene un Nodo
     *  @param s Nodo siguiente a un Nodo
     */
    NodoLEG(E e, NodoLEG<E> s) {
        this.dato = e;
        this.siguiente = s;
    }
   
    /** Crea un Nodo que contiene al Elemento e y al que no sigue ninguno
     *  @param e Elemento que contiene un Nodo
     */
    NodoLEG(E dato) { this(dato, null); } 
}