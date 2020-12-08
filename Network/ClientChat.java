package pract6;
import java.net.*;
import java.io.*;
import java.util.*;

public class ClientChat extends Thread
{
    Socket client;
    public ClientChat(Socket s){
        client = s;
    }
    public void run(){
        try{
            PrintWriter ClientOut = new PrintWriter((this.client).getOutputStream(),true);
            Scanner chatIn = new Scanner(System.in);
            String string = chatIn.nextLine();
            while(!string.equals("quit")){
                ClientOut.println(string);
                string = chatIn.nextLine();
            }
            ClientOut.println("quit");
            client.close();
        }
        catch(UnknownHostException e){
            System.out.println("Unknown Host");
            System.out.println(e);
        }
        catch(IOException e){
            System.out.println("Error ocurred");
            System.out.println(e);
        }
    }
    public static void main(String [] args){
        try{ 
            Socket ss = new Socket("localhost",7777);
            Scanner in = new Scanner(ss.getInputStream());
            ClientChat c = new ClientChat(ss);
            c.start();
            while(in.hasNext()){
                String string = in.nextLine();
                while(!string.equals("quit")){
                    System.out.println(string);
                    string = in.nextLine();
                }
            }
        }catch(UnknownHostException e){
            System.out.println("Unknown Host");
            System.out.println(e);
        }
        catch(IOException e){
            System.out.println("Error ocurred");
            System.out.println(e);
        }
    }
}
