package pract7;
import java.net.*;
import java.io.*;
import java.util.*;
/**
 * This UDP Server waits until receives any message from a client and returns date and time. 
 * You can run it on LTerminal  as a client using nc -u localhost 7777
 * Notice that if client does not send any message within 7 seconds, server will send a
 * SocketTimeoutEception
 */
public class Server
{
    public static void main(String []args) {
        try {
            DatagramSocket ds = new DatagramSocket(7777);
            ds.setSoTimeout(7000);
            byte[] buf = new byte[512];
            DatagramPacket dp = new DatagramPacket(buf, 512);
            ds.receive(dp);
            Date daytime = new Date();
            String daytimeString = daytime.toString() + "\r\n";
            dp.setData(daytimeString.getBytes());
            dp.setLength(daytimeString.length());
            ds.send(dp);
            ds.close();
        }catch (SocketTimeoutException e) { System.out.println("SocketTimeoutException"); }
         catch (SocketException e) { System.out.println("SocketException"); }
         catch (IOException e) { System.out.println("IOException");}
    }
}
