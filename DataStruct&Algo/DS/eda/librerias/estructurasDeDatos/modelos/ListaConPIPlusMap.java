package librerias.estructurasDeDatos.modelos;

public interface ListaConPIPlusMap<E> extends ListaConPI<E> {
    /** elimina los elementos repetidos de una ListaConPI, 
     *  dejando �nicamente su 1� aparici�n */
    void eliminarRepetidos(); 
    
    /** elimina los elementos de una ListaConPI que est�n en otra **/
    void diferencia(ListaConPI<E> otra);
} 