package pract6;


public class ThreeThreads extends Thread
{
    int id; // Identification of the thread
    public ThreeThreads(int i){ // ThreeThreads constructor
        this.id = i;
    }
    public void run(){ //method every thread executes
        try{
            for(int i = 0; i < 10; i++){
                System.out.println(this.id);
                sleep(1000);
            }
        }
        catch(InterruptedException e){ // exception occurred while executing run()
            System.out.println("Something went wrong");
        }
    }
    public static void main(String [] args){
        for(int i = 1; i <= 3; i++){
            ThreeThreads t = new ThreeThreads(i);
            t.start();
        }
    }
}
