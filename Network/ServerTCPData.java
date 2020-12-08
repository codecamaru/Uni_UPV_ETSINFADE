package pract5;
import java.util.*;
import java.io.*;
import java.net.*;
/**
 * Write a description of class ServerTCPData here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class ServerTCPData
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
                System.out.println("Objeto tipo ServerSocket: \n" + "dirección IP: " + ss.getInetAddress() + "\n número puerto:" + ss.getLocalPort());
                System.out.println("Objeto tipo Socket: \n" + "dirección IP: " + s.getInetAddress() + "\ndirección Local: " + s.getLocalAddress() + "\nnúmero puerto local:" + s.getLocalPort() + "\nnúmero puerto:" + s.getPort());
                s.close();
            }
        }
        catch(IOException e){
            System.out.println(e);
        }
    }
}
