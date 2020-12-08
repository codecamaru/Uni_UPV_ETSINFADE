package pract3;
import java.util.Scanner;
import java.io.*;
import java.net.*;

public class ClienteSMTP
{
    public static void main(String[] args) throws UnknownHostException, IOException{
        System.setProperty ("line.separator", "\r\n");
        try{
            Socket s = new Socket("smtp.upv.es",25);
            System.out.println("¡Conectado!");
            Scanner lee = new Scanner(s.getInputStream());
            System.out.println(lee.nextLine());
            PrintWriter salida = new PrintWriter(s.getOutputStream(),true);
            salida.println("HELO upv.es");
            System.out.println(lee.nextLine());
            salida.flush();
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
