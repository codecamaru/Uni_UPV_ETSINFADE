package librerias.estructurasDeDatos.lineales;

import librerias.estructurasDeDatos.modelos.ListaConPI;

public class LEGListaConPIPlus<E> extends LEGListaConPI<E> implements ListaConPIPlus<E>{
    
    /** comprueba si el Elemento e esta en una Lista Con PI **/
    public boolean contiene(E e){
        if(this.esVacia()){ return false; }
        this.inicio();
        for(int i = 0; i < this.talla(); i++){
            if(e == this.recuperar()){ return true; }
            this.siguiente();
        }
        return false;
    }

    /** elimina la primera aparicion del Elemento e en una Lista Con PI 
     *  y devuelve true, o devuelve false si e no esta en la Lista
     */
    public boolean eliminar(E e){
        if(this.esVacia()){ return false; }
        this.inicio();
        for(int i = 0; i < this.talla(); i++){
            if(e == this.recuperar()){ 
                this.eliminar();
                return true; 
            }
            this.siguiente();
        }
        return false;
    }

    /** si el Elemento e esta en una Lista Con PI elimina su ultima 
     *  aparicion y la devuelve como resultado; sino lo advierte 
     *  lanzando la Excepcion ElementoNoEncontrado 
     */
    public E eliminarUltimo(E e) throws ElementoNoEncontrado{
        if(this.esVacia()){ throw new ElementoNoEncontrado(); }
        for(int i = 1; i <= this.talla(); i++){
            this.inicio();
            for(int k = this.talla() - i; k > 0; k--){
                this.siguiente();
            }
            if(e == this.recuperar()){
                E ultAp = this.recuperar();
                this.eliminar();
                return ultAp;
            }

        }
        throw new ElementoNoEncontrado();
    }

    /** concatena una Lista Con PI con otra **/
    public void concatenar(ListaConPI<E> otra){
        if(!this.esVacia() && !otra.esVacia()){
            if(this.talla() >= otra.talla()){
                this.fin();
                otra.inicio();
                int i = 0;
                while(i < otra.talla()){
                    this.insertar(otra.recuperar());
                    otra.siguiente();
                    i++;
                }
            }
            else{
                otra.fin();
                this.inicio();
                int i = 0;
                while(i < this.talla()){
                    otra.insertar(this.recuperar());
                    this.siguiente();
                    i++;
                }
            }
        }
    }
}