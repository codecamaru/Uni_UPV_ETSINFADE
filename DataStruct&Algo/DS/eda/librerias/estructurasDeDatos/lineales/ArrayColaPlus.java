package librerias.estructurasDeDatos.lineales;

import librerias.estructurasDeDatos.modelos.*;

// Un ArrayColaPlus ES UN ArrayCola que implementa ColaPlus

public class ArrayColaPlus<E> extends ArrayCola<E> implements ColaPlus<E> {
    /** obtiene la talla de una Cola **/
    public final int talla() { 
        // usando unicamente los metodos que hereda de ArrayCola
        /* int res = 0;
           while (!this.esVacia()) { 
               E primero = this.desencolar(); 
               res++; 
           }
           return res;
        */
        //solución con el mismo coste lineal, pero que conserva los datos almacenados en la cola. 
     /*   if(super.principioC <= super.finalC){
            int talla = 0;
            for(int i = super.principioC; i <= super.finalC; i++){
                talla++;
            }
            return talla;
        }
        else{
            int talla = 0;
            for(int i = super.principioC; i >= super.finalC; i--){
                talla++;
            }
            return talla;
        }
    */

        // usando unicamente los atributos que hereda de ArrayCola, 
        // la mas eficiente
        return super.talla;
    }
}