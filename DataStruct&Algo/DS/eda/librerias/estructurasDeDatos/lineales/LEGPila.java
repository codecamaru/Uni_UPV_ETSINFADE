package librerias.estructurasDeDatos.lineales;

import librerias.estructurasDeDatos.modelos.*;

public class LEGPila<E> implements Pila<E> {
        
    protected NodoLEG<E> tope;
    protected int talla;

    /** crea una Pila vacia **/
    public LEGPila() {
        /*COMPLETAR*/
        talla = 0;
        tope = null;
    }
      
    /** inserta el Elemento e en una Pila, o lo situa en su tope **/
    public void apilar(E e) {
        /*COMPLETAR*/
        if(talla == 0){
            tope = new NodoLEG(e);
        }
        else{
            tope = new NodeLEG(e, tope);
        }
        talla++;
    }
      
    /** SII !esVacia(): 
     * obtiene y elimina de una Pila el Elemento que ocupa su tope 
     */
    public E desapilar() {
        /*COMPLETAR Y CORREGIR*/
        NodoLEG<E> top = tope;
        tope = tope.siguiente; 
        return top.dato;
    }
      
    /** SII !esVacia(): 
     * obtiene el Elemento que ocupa el tope de una Pila 
     */
    public E tope() {
        /*CORREGIR*/
        return tope.dato;
    }
      
    /** comprueba si una Pila esta vacia **/
    public boolean esVacia() {
        /*CORREGIR*/
        return talla <= 0;
    }
      
    /** obtiene un String con los Elementos de una Pila en orden LIFO, 
     *  inverso al de insercion, 
     *  y con el formato que se usa en el estandar de Java. 
     *  Asi, por ejemplo, si se tiene una Pila con los Integer del 1 al 4, 
     *  en orden LIFO, toString devuelve [4, 3, 2, 1]; 
     *  si la Pila esta vacia, entonces devuelve [] 
     */
    public String toString() { 
        StringBuilder res = new StringBuilder();
        res.append("["); 
        /*COMPLETAR*/
        NodoLEG<E> it = tope;
        for(int i = talla; i >= 1; i--){
            res.append(it.dato);
            it = it.siguiente;
        }
        res.append("]");
        return res.toString(); 
    }
}