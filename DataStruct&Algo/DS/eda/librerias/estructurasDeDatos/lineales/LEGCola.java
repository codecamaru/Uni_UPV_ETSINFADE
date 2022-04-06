package librerias.estructurasDeDatos.lineales;

import librerias.estructurasDeDatos.modelos.*;

public class LEGCola<E> implements Cola<E>{
    protected NodoLEG<E> first;
    protected NodoLEG<E> last;
    protected int talla;

    public LEGCola(){
        talla = 0;
        first = null;
        last = null;
    }

    public void encolar(E e){
        if(talla == 0){
            first = new NodoLEG(e);
            last = first;
        }
        else{
            last.siguiente = new NodoLEG(e);
            last = last.siguiente;
        }
        talla++;
    }

    public E desencolar(){
        NodoLEG<E> prim = first;
        first = first.siguiente;
        talla--;
        return prim.dato;
    }

    public E primero(){
        return first.dato;
    }

    public boolean esVacia(){
        return talla <= 0 && first == null;
    }

    public String toString(){
        StringBuilder res = new StringBuilder();
        res.append("[");
        if(talla > 0){ 
            NodoLEG<E> it = first; 
            res.append(it.dato);
            for(int i = talla - 1; i > 0; i--){
                it = it.siguiente;
                res.append(", " + it.dato);
            }
        }
        res.append("]");
        return res.toString();
    }

}