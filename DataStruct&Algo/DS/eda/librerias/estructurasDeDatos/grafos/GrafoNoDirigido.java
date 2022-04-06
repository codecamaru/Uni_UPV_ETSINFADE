package librerias.estructurasDeDatos.grafos;

/** 
 *  Clase GrafoNoDirigido
 *  
 *  implementacion de un grafo No Dirigido (Ponderado o no) 
 *  mediante Listas de Adyacencia
 *  
 *  un grafo No Dirigido ES UN Grafo Dirigido tal que 
 *  si la Arista (i, j) est� presente en la Lista de Adyacencia de i 
 *  entonces tambi�n lo est� la Arista (j, i) en la de j
 */

public class GrafoNoDirigido extends GrafoDirigido {
    
    /** Construye un grafo No Dirigido vacio con numVertices. 
     *  @param numVertices  Numero de vertices del grafo vacio
     */
    public GrafoNoDirigido(int numVertices) { 
        super(numVertices); 
        esDirigido = false;
    }
    
    /** Si no esta, inserta la arista (i, j) en un grafo 
     *  No Dirigido y No Ponderado; 
     *  por tanto, tambien inserta la arista (j, i).
     *  @param i    Vertice origen
     *  @param j    Vertice destino
     */ 
    public void insertarArista(int i, int j) {
        insertarArista(i, j, 1);
    }
    
    /** Si no esta, inserta la arista (i, j) de peso p en un grafo 
     *  No Dirigido y Ponderado; 
     *  por tanto, tambien inserta la arista (j, i) de peso p.
     *  @param i    Vertice origen
     *  @param j    Vertice destino
     *  @param p    Peso de (i, j)
     */ 
    public void insertarArista(int i, int j, int p) {
        if (!existeArista(i, j)) { 
            elArray[i].insertar(new Adyacente(j, p)); 
            elArray[j].insertar(new Adyacente(i, p));
            numA++; 
        }
    }
    
    /** Ejemplo 3, pagina 12, tema 6 */
    public int gradoEntrada(int i) {
        return gradoSalida(i);
    }

    /* Un método getVerticeReceptivo que devuelva el primer vértice (el de menor índice)
    del grafo con grado de Entrada |V|‐1, o ‐1 si no existe. */
    public int getVerticeReceptivo(){
        int receptivo = this.numV - 1;  
        for(int i = 0; i < this.numV; i++){
            int gradoEntrada = this.elArray[i].talla(); //del vertice actual
            if(gradoEntrada == receptivo){ return i; }
        }
        return -1;
    }

    /* Un método esSumidero que compruebe si un vértice v del grafo es un sumidero. Un
    Sumidero (Sink) es un vértice con grado de entrada > 0 y grado de salida 0 */
    public boolean esSumidero(int v){ return false; }

    /* Un método getSumideroU que devuelva el primer sumidero universal del grafo, o ‐1 si
    no existe. Un Sumidero Universal (Super Sink) es un vértice con grado de entrada |V|‐1
    y grado de salida 0. */
    public int getSumidero(){
        return -1;
    }

    /* Un método getFuenteU que devuelva la primera fuente universal del grafo, o ‐1 si no
    existe. Una Fuente Universal (Source) es un vértice con grado de entrada 0 y grado de
    salida |V|‐1.   */
    public int getFuente(){
        return -1;
    }

    /* Un método esCompleto que compruebe si el grafo es completo. Un grafo Completo es
    un grafo Simple donde cada par de vértices distintos están conectados por una única
    arista (bidireccional en el caso de GD). Equivalentemente, un grafo Simple es Completo
    si cada uno de sus vértices es adyacente al resto.   */
    public boolean esCompleto(){
        return 2 * numA == numV * (numV - 1); 
    }

    /* ‐ Implementa en la clase GrafoNoDirigido, con el menor coste posible, un método esConexo
    que compruebe si el grafo es conexo */
    // recuerda la existencia de int ordenVisita y int[] visitados
    public boolean esConexo(){
        ordenVisita = 0;
        visitados = new int[numVerticeS()];
        recorrerDFS(0);
        return ordenVisita == numVertices();
    }

    public void recorrerDFS(int i){
        visitados[i] = 1;
        ordenVisita++;
        LinkedList<Adyacente> l = adyacentesDe(i);
        for(l.inicio(); !l.esFin(); l.siguiente()){
            int w = l.recuperar().getDestino();
            if(visitados[w] == 0){ recorrerDFS(w); }
        }
    }

    /* Implemente un método toStringCC que devuelva un String con los vértices de las componentes conexas del grafo. */
    public String toStringCC() {
        String res = ""; visitados = new int[numVertices()];
        int nCC = 0;
        for (int v = 0; v < numVertices(); v++) {
        if (visitados[v] == 0) {
        nCC++; res += "[" + toStringCC(v) + "]\n";
        }
        }
        return "Hay " + nCC + " Componentes Conexas y son:\n" + res;
    }
    protected String toStringCC(int v) {
        String res = "" + v; visitados[v] = 1;
        ListaConPI<Adyacente> l = adyacentesDe(v);
        for (l.inicio(); !l.esFin(); l.siguiente()) {
        int w = l.recuperar().getDestino();
        if (visitados[w] == 0) { res += " " + toStringCC(w); }
        }
        return res;
    }

    /* Implementa un método spanningTree, que devuelva un Spanning Tree del grafo, o null si no hay Spanning Tree.
    En concreto, cuando encuentre un Spanning Tree, este método debe devolver un array de
    String, cada uno de los cuales representa una arista (v, w)  de las que componen el Spanning
    Tree. */
    protected int aristasTree; // atributo "auxiliar"
    public String[] spanningTree() {
        visitados = new int[numVertices()];
        String[] sTree = new String[numVertices() - 1];
        aristasTree = 0;
        spanningTree(0, sTree);
        if (aristasTree != numVertices() - 1) { return null; }
        return sTree;
    }
    protected void spanningTree(int v, String[] sTree) {
        visitados[v] = 1;
        ListaConPI<Adyacente> l = adyacentesDe(v);
        for (l.inicio(); !l.esFin(); l.siguiente()) {
            int w = l.recuperar().getDestino();
            if (visitados[w] == 0) {
                sTree[aristasTree++] = "(" + v + ", " + w + ")";
                spanningTree(w, sTree);
            }
        }
    }
}