package pract3;
import java.util.Scanner;
import java.io.*;
import java.net.*;

public class ClienteDayTime
{
    public static void main(String[] args) throws UnknownHostException, IOException{
        try{
            InetAddress dirIP = InetAddress.getByName("zoltar.redes.upv.es");
            Socket s = new Socket("zoltar.redes.upv.es",13);
            Scanner lee = new Scanner(s.getInputStream());
            System.out.println(lee.nextLine());
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
