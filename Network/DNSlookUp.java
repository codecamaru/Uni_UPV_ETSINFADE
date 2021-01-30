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
            InetAddress hostIPAddress = InetAddress.getByName(args[0]); // using static method getByName() from class InetAddress to obtain the IP coming from arguments
            System.out.println(hostIPAddress.toString()); // using toString method from class InetAddress to get a String with the type "<host name>/<IP Address>"
    
        }catch (UnknownHostException e) {
            System.out.println("UnknownHostException occurred");
        }
    }
}
