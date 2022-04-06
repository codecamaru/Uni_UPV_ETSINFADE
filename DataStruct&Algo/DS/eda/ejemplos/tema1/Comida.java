package ejemplos.tema1;

public class Comida implements Comparable<Comida>{
    private double calorias;
    // tiempo que se tarda en preparar
    private int minutos;

    public Comida(double c, int m) {
        calorias = c;
        minutos = m;
    }

    /*
    Compares this object with the specified object for order. Returns a negative integer, zero, or a positive integer as this object is less than, equal to, or greater than the specified object.
    una comida es preferible a otra si aporta menos calorías y, a igualdad de calorías, se prepara en un tiempo menor
    si this.calorias < e.calorias es preferible this y return 1
    si this.calorias > e.calorias es preferible e y return -1
    si this.calorias == e.calorias
        si this.minutos < e.minutos es preferible this y return 1
        si this.minutos > e.minutos es preferible e y return -1
        else son iguales y return 0
    */
    public int compareTo(Comida e){
        if(this.calorias < e.calorias){ return 1; }
        else{
            if(this.calorias > e.calorias){ return -1; }
            else{
                if(this.calorias == e.calorias){
                    if(this.minutos < e.minutos){ return 1; }
                    if(this.minutos > e.minutos){ return -1; }
                }
            }
        }
        return 0;
    }

   } 