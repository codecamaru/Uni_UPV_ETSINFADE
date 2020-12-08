package pract3;
import java.net.*;
import java.io.*;



public class ClienteTCP2
{
    public static void main(String[] args) throws UnknownHostException, IOException{
        Socket s = new Socket("wwww.upv.es",81);
        System.out.println("¡Conectado!");
        s.close();
    }
}