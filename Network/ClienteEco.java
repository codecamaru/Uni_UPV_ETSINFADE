package pract1;
import java.util.Scanner;
import java.io.*;
import java.net.*;

public class ClienteEco
{
    public static void main(String[] args) throws UnknownHostException, IOException{
        try{
            Socket s = new Socket("zoltar.redes.upv.es",7);
            System.out.println("¡Conectado!");
            PrintWriter salida = new PrintWriter(s.getOutputStream(),true);
            salida.println("¡¡Hola, Mundo!!");
            salida.flush();
            Scanner lee = new Scanner(s.getInputStream());
            System.out.println(lee.nextLine());
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
