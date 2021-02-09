package pract5;
import java.util.*;
import java.io.*;
import java.net.*;
/**
 * This is a sequential TCP echo Server. You can connect a Client to 7777 port with this server and everything you tell the server, it will echo you back!
 */
public class ServerTCP
{
    public static void main(String[] args){
        try{
            ServerSocket ss = new ServerSocket(7777);
            while(true){
                Socket s = ss.accept();
                Scanner entrada = new Scanner(s.getInputStream());
                String cadena = entrada.nextLine();
                PrintWriter salida = new PrintWriter(s.getOutputStream(),true);
                salida.println(cadena);
                System.out.println("Se ha conectado un cliente al servidor");
                s.close();
            }
        }
        catch(IOException e){
            System.out.println(e);
        }
    }
}
