package librerias.estructurasDeDatos.jerarquicos;

import librerias.estructurasDeDatos.jerarquicos.ABB;
import librerias.estructurasDeDatos.modelos.EntradaMap;
import librerias.estructurasDeDatos.modelos.MapOrdenado;
import librerias.estructurasDeDatos.modelos.ListaConPI;

public class ABBMapOrdenado<C extends Comparable<C>,V> implements MapOrdenado<C,V>{

    protected ABB<EntradaMap<C,V>> abb;

    public ABBMapOrdenado(){
        abb = new ABB<EntradaMap<C,V>>();
    }

    public boolean esVacio(){
        return abb.esVacio();
    }

    public int talla(){ return talla(abb); }

    /** devuelve el valor asociado a la clave c en un Map,
     *  null si no existe una Entrada con dicha clave
     */
    public V recuperar(C c){
        EntradaMap<C,V> e = abb.recuperar(new EntradaMap<C,V>(c,null));
        return e != null ? e.getValor() : null;
    }

    /** inserta la Entrada (c,v) en un Map y devuelve null; si ya
     *  existe una Entrada de Clave c en el Map, devuelve su valor 
     *  asociado y lo substituye por v (o actualiza la Entrada)
     */
    public V insertar(C c, V v){
        EntradaMap<C,V> e = abb.recuperar(new EntradaMap<>(c,null));
        abb.insertar(new Entrada<C,V>(c,v));
        return e != null ? e.getValor() : null;
    }

    /** elimina la Entrada con Clave c de un Map y devuelve su 
     *  valor asociado, null si no existe una Entrada con dicha clave
     */
    public V eliminar(C c){
        EntradaMap<C,V> e = abb.recuperar(new EntradaMap<C,V>(c,null));
        abb.eliminar(new EntradaMap<C,V>(c,null));
        return e != null ? e.getValor() : null;
    }

    /** devuelve una ListaConPI con las talla() Claves de un Map */
    public ListaConPI<C> claves(){
        ListaConPi<EntradaMap<C,V>> l = abb.toLista();
        ListaConPI<C> res = new LEGListaConPI<C>();
        for(l.inicio(); !l.esFin(); l.siguiente()){
            res.insertar(l.recuperar().getClave());
        }
        return res;
    }

    /** SII !esVacio(): 
     *  recupera la Entrada de Clave minima de un Map Ordenado */
    public EntradaMap<C, V> recuperarEntradaMin(){
        return this.abb.recuperarMin();
    }
    /** SII !esVacio(): recupera la Clave minima de un Map Ordenado */
    public C recuperarMin(){
        return this.recuperarEntradaMin().getClave();
    } 
   
    /** SII !esVacio(): 
     *  recupera la Entrada de Clave maxima de un Map Ordenado */
    public EntradaMap<C, V> recuperarEntradaMax(){
        return this.abb.recuperarMax();
    }
    /** SII !esVacio(): recupera la Clave maxima de un Map Ordenado */
    public C recuperarMax(){
        return this.recuperarEntradaMax().getClave();
    } 

    /** SII !esVacio(): recupera la Entrada siguiente a c
     *  segun el orden establecido entre claves */
    public EntradaMap<C, V> sucesorEntrada(C c){
        return this.abb.sucesor(new EntradaMap<C,V>(c, null));
    }  
    /** SII !esVacio(): recupera la clave siguiente a c
     *  segun el orden establecido entre claves */
    public C sucesor(C c){
        return sucesorEntrada(c).getClave();
    } 
    
    /** SII !esVacio(): recupera la Entrada anterior a c
     *  segun el orden establecido entre claves */
    public EntradaMap<C, V> predecesorEntrada(C c){
        return this.abb.predecesor(new EntradaMap<C,V>(c, null));
    }  
    /** SII !esVacio(): recupera la clave anterior a c
     *  segun el orden establecido entre claves */
    public C predecesor(C c){
        return predecesorEntrada(c).getClave();
    } 
    
    /** SII !esVacio(): 
     * elimina y devuelve la Entrada de Clave minima de un Map Ordenado */
    public EntradaMap<C, V> eliminarEntradaMin(){
        return this.abb.eliminarMin();
    }
    /** SII !esVacio(): 
     *  elimina y devuelve la Clave minima de un Map Ordenado */
    public C eliminarMin(){
        return this.eliminarEntradaMin().getClave();
    }

}