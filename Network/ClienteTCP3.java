package pract3;
import java.net.*;
import java.io.*;

public class ClienteTCP3
{
    public static void main(String[] args) throws UnknownHostException, IOException{
        try{
            Socket s = new Socket("www.upv.es",80);
            System.out.println("¡Conectado de nuevo!");
            System.out.println(s.getPort());
            System.out.println(s.getInetAddress());
            System.out.println(s.getLocalPort());
            System.out.println(s.getLocalAddress());
            s.close();
        }
        catch(UnknownHostException e){
            System.out.println("Nombre de servidor desconocido");
        }
        catch(ConnectException e){
            System.out.println("No es posible realizar la conexión");
        }
    }
}