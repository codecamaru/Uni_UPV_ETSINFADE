package ejemplos.tema3;

public class Matricula {   
    private int numeros; 
    private String letras;  

    public Matricula(int n, String l) { numeros = n; letras = l; }   

    public int getNumeros() { return numeros; }   

    public String getLetras() { return letras; }   

    public String toString() { return "Matricula " + numeros + " " + letras; }
    
    // ANYADIR LOS METODOS A PARTIR DE AQUI

    public boolean equals(Object o){
        if(Matricula instanceof o && this.numeros == ((Matricula) o).numeros && this.letras.equals(((Matricula) o).letras)){
            return true;
        }
        else{ return false; }
    }

    public int hashCode(){
        return (this.numeros + this.letras).hashCode();
    }
}