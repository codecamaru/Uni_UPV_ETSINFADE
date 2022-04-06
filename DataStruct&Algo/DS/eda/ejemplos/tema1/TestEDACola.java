package ejemplos.tema1;
import librerias.estructurasDeDatos.modelos.*;
import librerias.estructurasDeDatos.lineales.*;

public class TestEDACola {
  public static void main(String[] args) {      
      Cola<Integer> q = new ArrayColaPlus<Integer>();

      System.out.println("Creada una Cola con " + q.talla()
          + " Integer, q = " + q.toString());

      q.encolar(new Integer(10)); 
      q.encolar(new Integer(20)); 
      q.encolar(new Integer(30));
      System.out.println("La Cola de Integer actual es q = " + q.toString());

      System.out.println("Usando otros metodos para mostrar sus Datos el resultado es ...");
      String datosQ = "";
      while (!q.esVacia()) {
          Integer primero = q.primero();
          if (primero.equals(q.desencolar())) datosQ += primero + " "; 
          else datosQ += "ERROR ";
      }
      System.out.println(" el mismo, " + datosQ 
          + ", PERO q se vacia, q = " + q.toString());
  }
}