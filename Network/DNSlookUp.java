package pract7;
import java.net.*;
import java.io.*;

/**
 * This program takes a host name as an argument and prints the host name 
 * and its IP Address. In case there is no information about the host, it prints
 * an error message.
 */
public class DNSlookUp
{
    public static void main(String []args) {
        try {
            InetAddress hostIPAddress = InetAddress.getByName(args[0]);
            System.out.println(hostIPAddress.toString());
    
        }catch (UnknownHostException e) {
            System.out.println("UnknownHostException occurred");
        }
    }
}
