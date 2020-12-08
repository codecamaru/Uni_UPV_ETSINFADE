package pract6;
import java.io.*;
import java.net.*;

public class ConcurrentServer
{
    public static void main(String [] args) throws UnknownHostException, IOException{
        int port = 7777;
        ServerSocket server = new ServerSocket(port); // this Server will attend the concurrent clients
        while(true){
            Socket client = server.accept(); // Server is listening and waiting for clients to be attended 
            Attend p = new Attend(client); // Client is asigned to a class that will attend his petition
            p.start(); // object Attend is started (Attend extends Thread)
        }
    }
}
