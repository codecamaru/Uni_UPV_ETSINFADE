package librerias.estructurasDeDatos.jerarquicos;

import librerias.estructurasDeDatos.modelos.Cola;

import java.util.NoSuchElementException;

import librerias.estructurasDeDatos.lineales.ArrayCola;
import librerias.util.Ordenacion;

/** Clase ABB<E> que representa un Arbol Binario mediante un enlace 
 *  a su actual raiz. Sus caracteristicas son las siguientes: 
 *  1.- El tipo de sus elementos es E extends Comparable<E>
 *  2.- ATRIBUTOS (protected para la herencia): 
 *      TIENE UN NodoABB<E> raiz
 *
 * @version Noviembre 2021
 **/
 
public class ABB<E extends Comparable<E>> {
    // Atributo de la classe ABB
    protected NodoABB<E> raiz;

    /** 
     * Constructor de un ABB vacio 
     **/
    public ABB() { raiz = null; }
    
    /**
     * Constructor de un ABB con los elementos del vector dado.
     * El ABB resultante debe estar equilibrado.
     * @param v Array con los elementos a insertar en el ABB
     */
    public ABB(E[] v) {        
        // COMPLETAR       
    }
    
    /**
     * Construye un ABB equilibrado con los elementos del vector dado.
     * @param v     Array con los elementos a insertar en el ABB
     * @param ini   Inicio del intervalo a considerar en el vector
     * @param fin   Fin del intervalo a considerar en el vector
     * @return Raiz del subárbol
     */
    protected NodoABB<E> construirEquilibrado(E[] v, int ini, int fin) {
        // COMPLETAR  
        return null;
    }
    
    /** 
     * Reconstruye el ABB, con los mismos datos, de forma que quede 
     * equilibrado        
     */
    public void reconstruirEquilibrado() {        
        // COMPLETAR        
    }
    
    /**
     * Devuelve el sucesor de un elemento en el ABB
     * @param e Elemento cuyo sucesor se va a buscar
     * @return  Sucesor de "e", o null si no hay sucesor
     */
    public E sucesor(E e) {
        NodoABB<E> res = sucesor(e, this.raiz);
        if (res == null) { return null; }
        return res.dato; 
    }
    
    /** 
     * SII actual != null: devuelve el nodo de actual que contiene 
     * al sucesor de "e", o null si no existe
     * @param e         Elemento cuyo sucesor se va a buscar
     * @param actual    Nodo actual en la busqueda
     * @return  Sucesor de "e" en el nodo actual, o null si no existe
     */
    protected NodoABB<E> sucesor(E e, NodoABB<E> actual) {
        NodoABB<E> res = null;
        if (actual != null) {
            int resC = actual.dato.compareTo(e);
            if (resC > 0) {
                res = sucesor(e, actual.izq);
                if (res == null) { res = actual; }
            } else {
                res = sucesor(e, actual.der);
            }
        }
        return res;
    }

    /**
     * Devuelve el predecesor de un elemento en el ABB
     * @param e Elemento cuyo predecesor se va a buscar
     * @return  predecesor de "e", o null si no hay predecesor
     */
    public E predecesor(E e) {
        NodoABB<E> res = predecesor(e, this.raiz);
        if (res == null) { return null; }
        return res.dato; 
    }
    
    /** 
     * SII actual != null: devuelve el nodo de actual que contiene 
     * al predecesor de "e", o null si no existe
     * @param e         Elemento cuyo predecesor se va a buscar
     * @param actual    Nodo actual en la busqueda
     * @return  predecesor de "e" en el nodo actual, o null si no existe
     */
    protected NodoABB<E> predecesor(E e, NodoABB<E> actual) {
        NodoABB<E> res = null;
        if (actual != null) {
            int resC = actual.dato.compareTo(e);
            if (resC > 0) {
                res = sucesor(e, actual.izq);
                
            } 
            else if(resC == 0){
                if(actual.izq != null){
                    res = sucesor(e,actual.izq);
                    if (res == null) { res = actual; }
                }
            }
            else {
                res = sucesor(e, actual.der);
                if (res == null) { res = actual; }
            }
        }
        return res;
    }
    
    /** Busca el valor dado en el ABB
     * @param    e       Elemento a buscar
     * @return   Dato en el ABB que coincide con e, null si no hay          
     */
    public E recuperar(E e) {
        NodoABB<E> res = recuperar(e, raiz);
        if (res == null) { return null; }
        return res.dato;
    }
    
    /** Busca el valor dado a partir del nodo actual
     * @param    e       Elemento a buscar
     * @param    actual  Nodo actual en la busqueda
     * @return   Dato en el ABB que coincide con e, null si no hay          
     */
    protected NodoABB<E> recuperar(E e, NodoABB<E> actual) {
        if (actual == null) { return null; }
        int cmp = e.compareTo(actual.dato);
        if (cmp < 0) { return recuperar(e, actual.izq); }
        if (cmp > 0) { return recuperar(e, actual.der); }
        return actual; 
    }
    
    /** Actualiza el dato e en el ABB, si no esta lo inserta 
     * @param    e       Elemento a insertar/actualizar
     */
    public void insertar(E e) {  raiz = insertar(e, raiz); }
    
    /** Actualiza el dato e a partir del nodo actual. Si no esta lo inserta 
     * @param    e       Elemento a insertar/actualizar
     * @param    actual  Nodo actual en la busqueda
     * @return   Nodo raiz del subarbol cuya raiz actual es el nodo actual 
     */
    protected NodoABB<E> insertar(E e, NodoABB<E> actual) {
        if (actual == null) { return new NodoABB<E>(e); }
        int cmp = e.compareTo(actual.dato);
        if (cmp < 0) { actual.izq = insertar(e, actual.izq); }
        else if (cmp > 0) { actual.der = insertar(e, actual.der); }
        else { actual.dato = e; }
        actual.talla = 1 + talla(actual.izq) + talla(actual.der);
        return actual;
    }
    
    /**
     * Devuelve el numero de elementos del ABB
     * @return Talla del ABB
     */
    public int talla() { return talla(raiz); }

    /**
     * Devuelve el tamanyo del nodo actual
     * @param actual   Nodo actual
     * @return Tamanyo del nodo actual
     */
    protected int talla(NodoABB<E> actual) {
        if (actual == null) { return 0; }
        return actual.talla; 
    }
  
    /**  SII !esVacio(): devuelve el elemento minimo del ABB
      * @return Elemento minimo  
      */
    public E recuperarMin() { return recuperarMin(raiz).dato; }
    
    /** Devuelve el elemento minimo a partir del nodo actual 
     * @param    actual  Nodo actual en la busqueda
     * @return   Nodo que contiene el elemento mínimo 
     */
    protected NodoABB<E> recuperarMin(NodoABB<E> actual) {
        if (actual.izq == null) { return actual; } 
        return recuperarMin(actual.izq); 
    }

    /**  SII !esVacio(): devuelve el elemento máximo del ABB
      * @return Elemento máximo  
      */
      public E recuperarMax() { return recuperarMax(raiz).dato; }
    
      /** Devuelve el elemento máximo a partir del nodo actual 
       * @param    actual  Nodo actual en la busqueda
       * @return   Nodo que contiene el elemento máximo
       */
      protected NodoABB<E> recuperarMax(NodoABB<E> actual) {
          if (actual.der == null) { return actual; } 
          return recuperarMax(actual.izq); 
      }

    /** SII !esVacio(): elimina el minimo del ABB
     * @return Elemento minimo del ABB (null si esta vacio)
     */
    public E eliminarMin() {
        E min = recuperarMin();
        raiz = eliminarMin(raiz);
        return min;
    }
 
    /** Elimina el minimo a partir del nodo actual
     * @param    actual  Nodo actual en la busqueda
     * @return Nodo raiz del subarbol cuya raiz actual es el nodo actual
     */
    protected NodoABB<E> eliminarMin(NodoABB<E> actual) {
        if (actual.izq == null) { return actual.der; }
        actual.izq = eliminarMin(actual.izq);
        actual.talla--;
        return actual;
    }
  
    /** Elimina el nodo que contiene el dato e 
     * @param  e   Dato a eliminar
     */
    public void eliminar(E e) { raiz = eliminar(e, raiz); }
    
    /** Elimina el nodo que contiene el dato e a partir del nodo actual 
     * @param  e       Dato a eliminar
     * @param  actual  Nodo actual en la busqueda
     * @return Nodo raiz del subarbol cuya raiz actual es el nodo actual
     */
    protected NodoABB<E> eliminar(E e, NodoABB<E> actual) {
        if (actual == null) { return actual; }
        int cmp = e.compareTo(actual.dato);
        if (cmp < 0) { actual.izq  = eliminar(e, actual.izq); }
        else if (cmp > 0) { actual.der = eliminar(e, actual.der); }
        else {
            if (actual.der == null) { return actual.izq; }
            if (actual.izq  == null) { return actual.der; }
            actual.dato = recuperarMin(actual.der).dato;
            actual.der = eliminarMin(actual.der);
        }
        actual.talla = 1 + talla(actual.izq) + talla(actual.der);
        return actual;
    }
  
    /**
     * Devuelve true si el ABB esta vacio
     * @return true si esta vacio, false en caso contrario
     */
    public boolean esVacio() { return raiz == null; }
  
    /**
     * Recorrido inOrden del ABB
     * @return String con los elementos segun el recorrido inOrden
     */
    public String toStringInOrden() {
        StringBuilder sb = new StringBuilder().append("[");
        if (raiz != null) { toStringInOrden(sb, raiz); }
        return sb.append("]").toString();
    }
    
    /**
     * Recorrido inOrden a partir del nodo actual
     * @param sb      StringBuilder para ir construyendo la cadena de texto 
     * @param actual  Nodo actual en la busqueda
     */
    protected void toStringInOrden(StringBuilder sb, NodoABB<E> actual) {
        if (actual.izq != null) {
            toStringInOrden(sb, actual.izq);
            sb.append(",");
        }
        sb.append(actual.dato.toString());
        if (actual.der != null) { 
            sb.append(",");
            toStringInOrden(sb, actual.der); 
        }
    }

    /**
     * Recorrido en preOrden del ABB
     * @return String con los elementos segun el recorrido preOrden
     */
    public String toStringPreOrden() {
        StringBuilder sb = new StringBuilder().append("[");
        if (raiz != null) { toStringPreOrden(sb, raiz); }
        return sb.append("]").toString();
    }
    
    /**
     * Recorrido preOrden a partir del nodo actual
     * @param sb      StringBuilder para ir construyendo la cadena de texto 
     * @param actual  Nodo actual en la busqueda
     */
    protected void toStringPreOrden(StringBuilder sb, NodoABB<E> actual) {
        sb.append(actual.dato.toString());
        if (actual.izq != null) {
            sb.append(",");
            toStringPreOrden(sb, actual.izq);
        }
        if (actual.der != null) {
            sb.append(",");
            toStringPreOrden(sb, actual.der);
        }
    }

    /**
     * Recorrido en postOrden del ABB
     * @return String con los elementos segun el recorrido postOrden
     */
    public String toStringPostOrden() {
        StringBuilder sb = new StringBuilder().append("[");
        if (raiz != null) { toStringPostOrden(sb, raiz); }
        return sb.append("]").toString();
    }
    
    /**
     * Recorrido postOrden a partir del nodo actual
     * @param sb      StringBuilder para ir construyendo la cadena de texto 
     * @param actual  Nodo actual en la busqueda
     */
    protected void toStringPostOrden(StringBuilder sb, NodoABB<E> actual) {
        if (actual.izq != null) {
            toStringPostOrden(sb, actual.izq);
            sb.append(",");
        }
        if (actual.der != null) {
            toStringPostOrden(sb, actual.der);
            sb.append(",");
        }
        sb.append(actual.dato.toString());
    }
    
    /**
     * Recorrido por niveles del ABB
     * @return String con los elementos segun el recorrido por niveles
     */
    public String toStringPorNiveles() {
        if (this.raiz == null) { return "[]"; }
        StringBuilder res = new StringBuilder().append("[");
        Cola<NodoABB<E>> q = new ArrayCola<NodoABB<E>>();
        q.encolar(this.raiz);
        while (!q.esVacia()) {
            NodoABB<E> actual = q.desencolar();
            res.append(actual.dato.toString());
            res.append(", ");
            if (actual.izq != null) { q.encolar(actual.izq); }
            if (actual.der != null) { q.encolar(actual.der); }
        }
        // Por eficiencia, para borrar la ultima ", "
        // de res se resta 2 a su longitud actual
        res.setLength(res.length() - 2);
        return res.append("]").toString();
    }
    
    /**
     * Construye un array ordenado de forma creciente con todos los
     * elementos del ABB, resultado del recorrido en InOrden del mismo
     * @return Array con los valores del ABB segun el recorrido en InOrden
     */
    @SuppressWarnings("unchecked")
    public E[] toArrayInOrden() {
        E[] v = (E[]) new Comparable[talla()];
        toArrayInOrden(v, raiz, 0);
        return v;
    }
    
    /**
     * Construye un array ordenado de forma creciente con todos los
     * elementos a partir del nodo actual, siguiendo el recorrido en InOrden
     * @param v         Array con los elementos segun el recorrido en InOrden
     * @param actual    Nodo actual en el recorrido
     * @param pos       Posición en el array v
     */ 
    protected void toArrayInOrden(E[] v, NodoABB<E> actual, int pos) {
        if (actual != null) {
            toArrayInOrden(v, actual.izq, pos);
            int auxPos = pos + talla(actual.izq);
            v[auxPos++] = actual.dato;
            toArrayInOrden(v, actual.der, auxPos);    
        }
    }
    /* Devuelve en qué nivel se encuentra la primera aparición e de un ABB equilibrado en Pre-Orden o -1 si no se encuentra */ 
    public int enQueNivel(E e){
        if(this.raiz == null){ return -1; }
        return enQueNivel(e, this.raiz, 0);
    }
    /* param: 
        e: elemento cuyo nivel se quiere encontrar
        actual: nodo a inspeccionar en este momento
        nivelActual: nivel del nodo actual en entero
       return: 
        nivel en el que se encuentra la aparición o -1 si no se encuentra */
    protected int enQueNivel(E e, NodoABB<E> actual, int nivelActual){
        int res = -1; 
        int comp = actual.dato.compareTo(e);
        if(comp == 0){ res = nivelActual; }
        else{
            if(actual.izq != null && comp > 0){ 
                res = enQueNivel(e, actual.izq, nivelActual+1); }
            else if(actual.der != null && comp < 0){ 
                res = enQueNivel(e, actual.izq, nivelActual+1); }
        }
        return res; 
    }
    public int contarMayoresQue(E e, NodoABB<E> actual){
        int res = 0;
        if(actual != null){
            int comp = actual.dato.compareTo(e);
            if(comp > 0){
                res += 1 + actual.der.talla + contarMayoresQue(e, actual.izq);
            }
            else if(comp < 0){
                res += contarMayoresQue(e, actual.der);
            }
            else{
                res += 1 + actual.der.talla;
            }
        }
        return res; 
    }
    /* Devuelve una ListaConPI de los datos de los nodos (una lista de Entradas) del abb this
    coste T(x) E o(x)
    */
    public ListaConPi<E> toLista(){
        ListaConPi<E> l = new LEGListaConPI<>();
        if(this.raiz != null){ toLista(this.raiz,l); }
        return l;
    }
    protected void toLista(NodoABB<E> actual, ListaConPi<E> l){
        if(actual.izq != null){
            toLista(actual.izq,l);
        }
        l.insert(actual.dato);
        if(actual.der != null){
            toLista(actual.der,l);
        }
    }

    /* devuelve un String con los datos del nivel k de un ABB */
    public String datosEnNivel(int k){
        StringBuilder sb = new StringBuilder().append("[");
        datosEnNivel(sb,this.raiz, 0, k);
        return sb.append("]").toString();
    }

    protected void datosEnNivel(StringBuilder sb, NodoABB<E> actual, int nivActual, int k){
        if(nivActual <= k){
            if(nivActual == k){
                if(actual == null){ sb.append("null"); }
                else{ sb.append(actual.dato.toString());}
            }
            else{
                datosEnNivel(sb,actual.izq,nivActual+1,k);
                datosEnNivel(sb,actual.der,nivActual+1,k);
            }
        }
    }

    public int alturaDeEquilibrado() throws NoSuchElementException{
        return alturaDeEquilibrado(this.raiz);
    }

    protected int alturaDeEquilibrado(NodoABB<E> actual) throws NoSuchElementException{
        if(actual == null){ return 0; }
        else{
            int alturaIzq = alturaDeEquilibrado(actual.izq);
            int alturaDer = alturaDeEquilibrado(actual.der);
            int dif = Math.abs(alturaIzq - alturaDer);
            if(dif > 1){
                throw new NoSuchElementException("No es equilibrado");
            }
            return 1 + Math.max(alturaIzq, alturaDer);
        }
    }

    public E padreDe(E e) {
        if (raiz != null && raiz.dato.compareTo(e) == 0) return null;
        return padreDe(raiz, e);
    }
    protected E padreDe(NodoABB<E> n, E e) {
        if (n == null) { return null; }
        if (n.izq != null && n.izq.dato.compareTo(e) == 0) {
            return n.dato;
        }
        if (n.der != null && n.der.dato.compareTo(e) == 0) {
            return n.dato;
        }
        int resC = n.dato.compareTo(e);
        if (resC < 0) { return padreDe(n.der, e); }
        else { return padreDe(n.izq, e); }
    }

    public E hermanoDe(E e) {
        if (raiz != null && raiz.dato.compareTo(e) == 0) return null;
        return padreDe(raiz, e);
    }
    protected E hermanoDe(NodoABB<E> n, E e) {
        if (n == null) { return null; }
        if (n.izq != null && n.izq.dato.compareTo(e) == 0) {
            if(n.der != null){ return n.der.dato;}
            else { return null; } 
        }
        if (n.der != null && n.der.dato.compareTo(e) == 0) {
            if(n.izq != null){ return n.izq.dato;}
            else { return null; }
        }
        int resC = n.dato.compareTo(e);
        if (resC < 0) { return hermanoDe(n.der, e); }
        else { return hermanoDe(n.izq, e); }
    }

}