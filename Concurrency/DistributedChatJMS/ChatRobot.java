
//import ui.ChatClientFace;
//import ui.ChatUIFace;
import java.util.List;
import javax.jms.ConnectionFactory;
import javax.jms.JMSConsumer;
import javax.jms.JMSContext;
import javax.jms.JMSProducer;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.Topic;
import javax.naming.InitialContext;
import messages.AMessage;
import messages.ChatMessage;
import messages.MessageFactory;
import messages.ConnectOkMessage;
import messages.JoinMessage;
import messages.JoinOkMessage;
import messages.UserJoinsMessage;
import messages.UserLeavesMessage;
//import ui.ChatUI;
import utils_jms.InitialContextLoader;
import utils_jms.JMSChatConfiguration;
import utils_jms.TheInitialContext;
//import utils.SynchroMap;
import static utils_jms.Destinations.CHANNEL_TOPIC;
import static utils_jms.Destinations.SERVER_QUEUE;
import static utils_jms.Destinations.USER_QUEUE;


/**
 * ChatRobot program built using JMS
 * 
 * Connects to a specific channel (default: Spain channel)
 * Keeps in a loop to process messages that arrive to the channel
 * and in case of JOIN messages, sends a welcome message to the channel
 *
 */

public class ChatRobot
{

    // Our initial configuration
    private final JMSChatConfiguration conf;
    
    // Initial context
    private TheInitialContext tic; 
    
    // Our nick name
    private String nick;

    //Channel name to which we connect
    private String myChannelName;

    // Queue where we send messages to ChatServerJMS
    private Queue serverQueue;
        
    // Lists of users and channels registered at the system    /* NOTA: ESTO NO SERIA NECESARIO */
    private String[]   users;
    private String[]   channels;
    
    // TOPIC channel where we receive the messages send to the channel
    private Topic channelTopic;

    
    /**
     * Create a ChatRobot program.
     * 
     * @param conf configuration
     */    
    private ChatRobot (JMSChatConfiguration conf) {
        this.conf = conf;
        
    }
  
     public void setChannelName(String name) {
       myChannelName = name;
     }

     public void setNickName(String name) {
       nick = name;
     }

     public String getNick() {
        return nick;
     }
    
    public String getChannelName() {
       return myChannelName;
     }
    
    /**
     * Connect to Artemis and obtain the server queue
     * 
     * @param serverUrl server url where artemis runs
     * 
     * @throws Exception Erros
     */
    
    public void connectArtemis (String serverUrl) throws Exception {  
      /** Complete this code where it is indicated. You can use ChatClienJMS code as a guideline **/

        // Sanity check on ServerURL
        //
        String url = JMSChatConfiguration.normalizeUrl(serverUrl);
        if (url == null) {
            throw new Exception ("Wrong URL: " + serverUrl);
        } else serverUrl = url;
        
        //
        // Save the user-provided serverUrl as the current artemis URL
        //
        InitialContextLoader.setDefaultArtemisURL (serverUrl);
        
        // 
        // Create the JMS initial context
        InitialContext ic = InitialContextLoader.getInitialContext();
        
        // 1. Connect using same connection factory as other clients and the server do.        
        /** TO COMPLETE **/



        // 2. Create a default JMS context.
        // This is where we really contact Artemis
        /** TO COMPLETE **/

      

        
        // 3. Save initial context to be used later
        // We use this initial context information to create new contexts and to
        // close connection later.
        /** TO COMPLETE **/
      

                
        // 4. Get server queue and keep it as a global, since we use it often
        /** TO COMPLETE **/
     

    }

    /**
     * Connect to our ChatServerJMS. 
     *
     <p> Connect means to send a CONNECT message to the server and wait for reply.
     <p> This reply includes the list of users and channels registered at the server.
     * @param nick Our nick name 
     * 
     * @throws Exception Error
     */
    public void callServerConnect (String nick) throws Exception {  
      /** Complete this code where it is indicated. You can use ChatClienJMS code as a guideline **/

        // 1. Create a new specific context for this request (thread-safe)
        JMSContext ctx = null;
         /** TO COMPLETE **//** TO COMPLETE **/
        
        // 2. Create a producer
        /** TO COMPLETE **/
        

        // 3. Build a message of type "ConnectMessage" (to indicate Server that we want to connect)
        /** TO COMPLETE **/
   


        // 4. Create a temporary queue to receive server reply. 
        /** TO COMPLETE **/
        

        // 5. Set the "replyTo" property at the message, linked to our temporary queue. 
        // So we will let our server know where to reply.
        /** TO COMPLETE **/
                


        // 6. Send the message            
        try { 
            /** TO COMPLETE **/
        } catch (Exception e) {
            // The most likely reason is that queue does not exist. Meaning, it ChatServerJMS never
            // run after installing Artemis.
            ctx.close();
            throw new Exception ("Cannot send message to ChatServerJMS queue");
        }
        
        // 7. Create a consumer to receive from our temporary queue
        JMSConsumer consumer = null;
        /** TO COMPLETE **/
        
        // 8. Wait 1 second for the message. 
        ObjectMessage m = null ; /** TO COMPLETE **/
     
        if (consumer != null) {
             consumer.close(); // Free up resources for this temporary queue.
        }
        
        //This is a synchronous wait. We don't proceed until server confirms connection.
        // We have waited for 1 second.  If we received no answer, ChatServerJMS is not online.
        if (m == null) {
            // ChatServerJMS won't be able to answer us anymore.
            if (consumer != null) {
                consumer.close();   
                ctx.close();
            }
            throw new Exception ("ChatServerJMS not responding.");
        }
        
        
        // 9. Get the message contents.
        ConnectOkMessage myobject = null;
        /** TO COMPLETE **/
        


        // Get list of users and channels from the message contents.
        //

           List<String> usersList = myobject.getUsers();
           List<String> channelsList = myobject.getChannels();
        
        
        // Server didn't allow connection, if channel list is empty.
        //
        if (channelsList.isEmpty()) {
            ctx.close();
            throw new Exception ("Server denied connection. Possible nick duplicate.");
        }
                
        // Finally we update the list of users and channels
        //
        this.users = usersList.toArray (new String [usersList.size()]);    
        this.channels = channelsList.toArray (new String [usersList.size()]);  
    }

  
    /**
     * Join to the specified channel. 
     *  <p> Send a Join message to the ChatServerJMS and wait for reply.
     *  <p> Get the link to the specified channel TOPIC
     * @param channelName channel to join
     * @param nick  of the ChatRobot
     * @throws Exception Error
     */
   // @Override
    public void doJoinChannel(String channelName, String nick) throws Exception {   
        // 1. Create new context for this request. And create a producer
        /** TO COMPLETE **/

        
        // 2. Create a temporary queue to receive server reply
        /** TO COMPLETE **/
        
        // 3. Create message of type Join. And set the "replyTo" property linked to our temporary queue,
        // to let the server know where to reply. 
        Message msg;
        /** TO COMPLETE **/
        

        // 4.Send the message to chatServer queue      
        /** TO COMPLETE **/

        // 5. Create a consumer of the temporary queue. And Wait to receive the message
       /** TO COMPLETE **/
        
        // 6. Get data from reply. It must be a JoinOK message.
        /** TO COMPLETE **/
   
        //7. Obtain the channel TOPIC. This is the destiny (Topic) of the channel we are joining. 
        channelTopic = (Topic) tic.ic().lookup (CHANNEL_TOPIC + myChannelName);
        
    }

    
    /**
     * Sends a channel message to the channel already joined
     * 
     * @param msg message to send
     * @throws Exception errors while sending the message
     */    
    //@Override
    public void doSendChannelMessage(String msg) throws Exception {
        // 
        // Our server implementation has no control on who sends a channel message.
        //
        // Actually, anyone, even the Artemis Console itself could send a message.
        // Security concerns should be considered into Artemis configuration, more
        // than here.
        //
        // Having said that, now we refuse sending messages if we didn't join this channel.

        //We assume that in channelTopic we have previously obtained the link to the corresponding channel queue
        if (channelTopic == null) {
            throw new Exception ("Join channel before sending messages ");
        } 
        
        // 1. Broadcast the message. For that: 
        // a) create a context 
        // b) create a producer for this context
        // c) create a message of type "chatMessage" 
        // d) send the message to the channel queue (reference stored at channelTopic attribute)
        // e) close the context 

           /** TO COMPLETE **/

    }


   /**
     * Run the ChatRobot loop.
     * 
     * <p> The loop iterates forever, waiting for a message and processing it. 
     * 
     * @throws Exception Error
     */
    private void runChatRobotLoop () throws Exception {
       // We assume that ChatRobot has already joined to the channel. 
       // And the reference to the channel queue is stored at channelTopic attribute
  
        // 1. Create my own Context.
         /** TO COMPLETE **/
        
        // 2. Create a consumer for the channel TOPIC
        //
        JMSConsumer cons = null;
        try {
             /** TO COMPLETE **/

        } catch (Exception e) {
            System.out.println ("ERROR ==> Problems when creating the channel consumer");
            return; // we end here.
        }

        while (true) {

            // We receive JOIN/LEAVE notifications and CHAT_MESSAGEs
            // Answer to JOIN messages
            // Note: see AMessage class (at messages folder) for message types

            // 3. Wait for a new client request.
            //
            // System.out.println("Waiting for clients to join ...");
            ObjectMessage msg = null; 
             /** TO COMPLETE **/
          
           if (msg != null) {
              // Get the message content            
              AMessage bmsg = (AMessage) msg.getObject();
              System.out.println ("OK ==> We received a message of type: " + bmsg.getType());
              switch (bmsg.getType()) {
                     case USER_JOINS: {

                         UserJoinsMessage jm = (UserJoinsMessage) bmsg;
                         System.out.println("Received message JOINS at channel " + myChannelName + " from nick: " + jm.getNick() );
                       
                       //4. Enviamos mensaje de saludo al canal
                        /** TO COMPLETE **/


                       break;  
                     }
                     case CHAT_MESSAGE: 
                     case USER_LEAVES:
                     default:
                           //do nothing 
                            break; 
                     
                }           
            }
        }
    }

  /**
     * ChatRobot Initialization routine
     * 
     * <p> Connect to Artemis, connect to our ChatServerJMS and start the ChatRobot loop.
     * 
     * @throws Exception Error
     */    

    public void startup() throws Exception {

        String serverUrl = this.conf.getArtemisUrl(); 
        System.out.println("OK ==> 'ChatRobot' running. Using artemis at " + serverUrl); 
        String nick = this.getNick();
        String channelName = this.getChannelName();
        System.out.println("ChatRobot JMS: tries to connect to: " + this.conf.getArtemisUrl() + " nick =" + nick + " channel=" + channelName);

        //Connecting ChatRobot to Artemis
        connectArtemis(serverUrl); 
        if (tic != null) { System.out.println("Connection to Artemis done."); }

        //Connecting ChatRobot to ChatServerJMS
        boolean connected = true; 
        try {
           callServerConnect(nick);     // Call server to connect. Users and channels will be updated
        } catch (Exception e) {
              connected = false;
              System.out.println("ChatServerJMS not responding");
        }

        if (connected) {
            //Shows users and channels registered at the application
            System.out.print("users: ");  
            for (String userName: this.users) { System.out.print(userName + "  "); }
        
            System.out.print("\n channels: ");
            for (String chName: this.channels)  { System.out.print(chName + "  "); }

            //Connecting ChatRobot to channelName 
            doJoinChannel(channelName, nick);

            //ChatRobot sends a welcome message to the channel
             doSendChannelMessage("Hello everyone!! This is " + nick);

            // Finally run the ChatRobot "forever", processing messages as they arrive in the channel
            runChatRobotLoop();
        }
    }



 /**
     * Main ChatRobot program
     * <p>Load configuration parameters from command line, create a new 
     *     ChatRobot object and start it.
     * 
     * @param args command line parameters
     */
    public static void main (String[] args) {

        JMSChatConfiguration conf = JMSChatConfiguration.parse(args);

        //Create ChatRobot instance 
        ChatRobot robot = new ChatRobot (conf);
        String nick = robot.conf.getNick();
        if (nick == null) { nick = "ChatRobot"; };  //default nick
        robot.setNickName(nick);

        String channel = robot.conf.getChannelName();
        if (channel == null) { channel = "Spain"; };  //default channel
        robot.setChannelName(channel);

        try {        
            robot.startup();
        } catch (Exception e) {
            System.err.println ("Error in ChatRobot: " + e);
            e.printStackTrace (System.err);
            System.exit(-1);
        }
    }

}
