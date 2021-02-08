package pract3;
import java.util.Scanner;
import java.io.*;
import java.net.*;

public class ClienteHTTP
{
  public static void main(String[] args) throws UnknownHostException, IOException{
        try{
            Socket s = new Socket("www.upv.es",80);
            System.out.println("¡Conectado!");
            PrintWriter salida = new PrintWriter(s.getOutputStream());
            salida.println("GET / HTTP/1.0\r\n\r\n");
            salida.flush();
            Scanner lee = new Scanner(s.getInputStream());
            while(lee.hasNext()){
                System.out.println(lee.nextLine());
            }
            s.close();
            System.out.println("Desconectado");
        }
        catch(UnknownHostException e){
            System.out.println("Nombre de servidor desconocido");
        }
        catch(ConnectException e){
            System.out.println("No es posible realizar la conexión");
        }
    }
 
}
