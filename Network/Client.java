package pract7;
import java.io.*;
import java.net.*;

/**
 * This UDP Client sends a datagram to port 7777 of your computer and waits for answer. 
 * Prints the answer. You can run it with nc -u -l localhost 7777 (server listening) 
 * and then type the answer.
 */
public class Client
{
    public static void main (String []args) {
        try{
            DatagramSocket ds = new DatagramSocket();
            ds.setSoTimeout(7000);
            InetAddress dir = InetAddress.getByName("localhost");
            String message = "This was short \r\n"; 
            byte[] buf = new byte[512];
            buf = message.getBytes();
            DatagramPacket dp = new DatagramPacket(buf,buf.length, dir,7777);
            ds.send(dp);
            ds.receive(dp);
            String answer = new String(dp.getData(), 0, dp.getLength());
            System.out.println(answer);
            ds.close();
        }catch (SocketTimeoutException e) { System.out.println("SocketTimeoutException"); }
         catch (SocketException e) { System.out.println("SocketException"); }
         catch (IOException e) { System.out.println("IOException");}
        
    }
}
