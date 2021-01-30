package pract7;
import java.net.*;
import java.io.*;

/**
 * This program sends a message tu your host with your name. You can run it on a Linux Terminal
 * with nc -u -l localhost 7777 or nc -u -k -l localhost 7777
 */
public class UDPClient 
{
    public static void main (String []args) {
        try{
            DatagramSocket ds = new DatagramSocket();
            int port = ds.getLocalPort();
            System.out.println(port);
            InetAddress dir = InetAddress.getByName("localhost");
            String nSn = /** insert name here -> */ "Name Surname \r\n"; 
            byte[] buf = new byte[256];
            buf = nSn.getBytes();
            DatagramPacket dp = new DatagramPacket(buf,buf.length, dir,7777);
            ds.send(dp);
            ds.close();
        }catch (SocketException e) { System.out.println("SocketException"); }
        catch (IOException e) { System.out.println("IOException");}
    }
}
