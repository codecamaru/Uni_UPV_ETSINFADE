package librerias.estructurasDeDatos.lineales;

import java.util.ArrayDeque;

public class ArrayDequeCola<E> extends ArrayDeque<E> implements Cola<E>{

    public ArrayDequeCola(int numElements){
        super(numElements);
    }
    public void encolar(E e){
        super.addLast(e);
    }
    public E desencolar(){
        return super.poll();
    }
    public E primero(){
        retrun super.getFirst();
    }
    public boolean esVacia(){
        return super.isEmpty();
    }
    public String toString(){
        StringBuilder res = new StringBuilder();
        res.append("[");
        E temp = super.pollFirst();
        super.addLast(temp);
        res.append(temp);
        for(int i = 1; i < super.size(); i++){
            temp = super.pollFirst();
            super.addLast(temp);
            res.append(", " + temp);
        }
        res.append("]");
        return res.toString();
    }

}
