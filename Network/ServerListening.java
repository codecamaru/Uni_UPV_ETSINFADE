package pract5;
import java.util.*;
import java.io.*;
import java.net.*;
/**
 * Write a description of class ServerListening here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class ServerListening
{
    public static void main(String[] args){
        System.setProperty("line.separator","\r\n");
        try{
            ServerSocket ss = new ServerSocket(8000);
            while(true){
                Socket s = ss.accept();
                Scanner in = new Scanner(s.getInputStream());
                PrintWriter out = new PrintWriter(s.getOutputStream(),true);
                out.print("HTTP/1.0 200 OK \r\n");
                out.print("Content-Type: text/plain\r\n");
                out.print("\r\n");
                String chain = in.nextLine();
                while(!chain.equals("")){
                    out.println(chain);
                    chain = in.nextLine();
                }
                s.close();
            }
        }
        catch(IOException e){
            System.out.println(e);
        }
    }
}
