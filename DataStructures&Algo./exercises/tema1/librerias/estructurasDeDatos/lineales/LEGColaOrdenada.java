package librerias.estructurasDeDatos.lineales;

public class LEGColaOrdenada<E> extends LEGCola<E> implements Comparable<E>{
    protected NodoLEG<E> aux;
    protected NodoLEG<E> ant;

    public LEGColaOrdenada(){
        super.LEGCola();
    }

    /* Compares this object with the specified object for order. 
    Returns a negative integer, zero, or a positive integer as this 
    object is less than, equal to, or greater than the specified object.
    */
    /*
    public int compareTo(NodoLEG e){
        if(this.dato > e.dato){ return 1; }
        if(this.dato < e.dato){ return -1; }
        return 0;
    }
    */
    

    @Override
    public void ecolar(E e){
        if(super.talla == 0){
            super.first = new NodoLEG(e);   // cola vacia
            super.last = first;
        }
        else{
            aux = super.first;
            if((aux.dato).compareTo(e) > -1){
                super.first = new NodoLEG(e,super.first);   // lo pongo en cabeza
            }
            else{
                ant = aux;
                aux = aux.siguiente;
                for(int i = 0; i < super.talla && ((aux.dato).compareTo(e) < 0); i++){
                    ant = aux;
                    aux = aux.siguiente;
                }
                if(i < super.talla){ ant.siguiente = new NodoLEG(e,aux); }
                else{
                    super.last = new NodoLEG(e);
                    aux.siguiente = super.last;
                }
            }
        }
        super.talla++;
    }

}