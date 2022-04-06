package librerias.estructurasDeDatos.lineales;

import java.util.ArrayDeque;

public class ArrayDequeCola<E> extends ArrayDeque<E> implements Cola<E>{

    public ArrayDequeCola(){
        super.arrayDeque(30000);
    }
    public void encolar(E e){
        super.addLast(e);
    }
    public E desencolar(){
        super.poll();
    }
    public E primero(){
        super.getFirst();
    }
    public boolean esVacia(){
        super.isEmpty();
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