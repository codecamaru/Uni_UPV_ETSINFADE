package pract6;
import java.net.*;
import java.util.*;
import java.io.*;

public class Attend extends Thread
{
    Socket client; 
    public Attend(Socket s){
        this.client = s;
    }
    public void run(){
        try{ 
            Scanner in = new Scanner((this.client).getInputStream());
            String string = in.nextLine();
            PrintWriter out = new PrintWriter((this.client).getOutputStream(),true);
            while(!string.equals("FIN")){
                out.println(string);
                string = in.nextLine();
            }
            out.println("FIN");
            client.close();
        }catch (UnknownHostException e){
            System.out.println("Unknown Host");
            System.out.println(e);
        }
        catch(IOException e){
            System.out.println("Connection fail occurred");
            System.out.println(e);
        }
    }
}
