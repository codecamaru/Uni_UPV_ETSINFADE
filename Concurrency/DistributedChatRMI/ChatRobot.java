//
// This file must be implemented when completing "ChatRobot activity"
//

import utils_rmi.ChatConfiguration;
import utils_rmi.RemoteUtils;
import faces.IChatMessage;
import faces.MessageListener;
import faces.INameServer;
import faces.IChatServer;
import faces.IChatUser;
import faces.IChatChannel;
import impl.ChatUserImpl;
import impl.ChatMessageImpl;
import java.rmi.*;
import java.rmi.registry.*;
import java.rmi.server.*;
import java.util.*;


/**
 * ChatRobot implementation
 * 
 * <p> Notice ChatRobot implements MessageListener. MUST not extend ChatClient.
 * 
 */

public class ChatRobot implements MessageListener
{

    private ChatConfiguration conf;
    public ChatRobot (ChatConfiguration conf) {
        this.conf = conf;
    }
    
   @Override
   public void messageArrived (IChatMessage msg)  {
       //*****************************************************************
       // Activity: implement robot message processing
       try{
       String emisor = (msg.getSender()).getNick();
       String destino = RemoteUtils.remote2String(msg.getDestination());
       String texto = msg.getText();
       System.out.println("Emisor: " + emisor + ", destino: " + destino + ", texto: " + texto);
       if(msg.isPrivate()){ System.out.println("El mensaje es privado"); }
       else{ System.out.println("El mensaje es publico"); }
       }
       catch(Exception e){
       	System.out.println(e);
       }
       
   }
   
   private void work () {
       
       String channelName = conf.getChannelName();
       if (channelName == null) channelName = "#Linux";
       System.out.println ("Robot will connect to server: '" + conf.getServerName() + "'" + 
               ", channel: '" + channelName + "'" + 
               ", nick: '" + conf.getNick() + "'" +        
               ", using name server: '" + conf.getNameServerHost() + ":" + conf.getNameServerPort() + "'");
       
       try {
           //*****************************************************************
           // Activity: implement robot connection and joining to channel
           // objeto referencia NS
           INameServer reg = INameServer.getNameServer(conf.getNameServerHost(), conf.getNameServerPort());
           System.out.println(RemoteUtils.remote2String(reg));
           // referencia al ChatServer
           IChatServer cs = (IChatServer)reg.lookup(conf.getServerName());
           System.out.println(RemoteUtils.remote2String(cs));
           // conectarse al Server con nick y referencia de this
           String nick = conf.getNick();
           IChatUser cu = new ChatUserImpl(nick, this);
           cs.connectUser(cu);
           System.out.println("Conectado!");
           // mostrar lista canales
           IChatChannel[] channelsList = cs.listChannels();
           System.out.println("Lista de canales: ");
           Boolean found = false;
           for(IChatChannel ch : channelsList){
           	String name = ch.getName();
           	System.out.println("   " + ch.getName() + " " + RemoteUtils.remote2String(ch));
           	if(name.equals(channelName)){ found = true; }
           	
           }
           if(found){ System.out.println("El nombre introducido pertenece a la lista, y es: " 			+ channelName); } 
           else{ System.out.println("El nombre introducido no pertenece a la lista "); }
           // unirse al canal
           IChatChannel myChannel = cs.getChannel(channelName);
           IChatUser[] users = myChannel.join(cu);
           if(users == null || users.length == 0){
           	throw new Exception("No users. This shouldn't happen once we join.");
           }
           System.out.println("Usuarios del canal: ");
           for(IChatUser usr : users){
           	System.out.println(" " + usr.getNick());
           }
           // mandar mansaje a canal
           IChatMessage msg = new ChatMessageImpl(cu, myChannel, "Hola a todos");
           myChannel.sendMessage(msg);
           // mandar mensaje privado
           for(IChatUser usr : users){
           	if(!(conf.getNick()).equals(usr.getNick())){
           		msg = new ChatMessageImpl(cu, usr, "Hola, soy un bot");
           		usr.sendMessage(msg);
           		break;
           	}
           }
           
       } catch (Exception e) {
           System.out.println("Something went wrong: " + e);
       }
       
   }

   public static void main (String args [])  {
       ChatRobot cr = new ChatRobot (ChatConfiguration.parse (args));
       cr.work ();
   }
}
