// CSD feb 2013 Juansa Sendra

public class Pool4 extends Pool { //kids cannot enter if there are instructors waiting to exit
    private int iNadando = 0;
    private int nNadando = 0;
    private static int maxKids = 2;
    private static int maxCapacity = 5;
    private int nNadadores = 0;
    private int iWaiting = 0;
    
    public void init(int ki, int cap)           {}
    public synchronized void kidSwims() throws InterruptedException {
    while (iWaiting > 0 || nNadadores == maxCapacity || nNadando+1 > maxKids*iNadando) { //COMPLETAR la condición
         log.waitingToSwim();//para visualizar la posición del nadador
         wait();
    }
     nNadando++;
     nNadadores++;//Actualiza estado (COMPLETAR)
     //Si necesario, avisa del nuevo estado a otros hilos
     // con notifyAll();
     log.swimming(); //para visualizar la posición del nadador
     }
    public synchronized void kidRests()      {
        nNadando--;
        nNadadores--;
        notifyAll();
        log.resting(); 
    }
    public synchronized void instructorSwims() throws InterruptedException  {
        while(nNadadores == maxCapacity){
            wait();
        }
        iNadando++;
        nNadadores++;
        notifyAll();
        log.swimming();
    }
    public synchronized void instructorRests() throws InterruptedException {
        iWaiting++;
        while(nNadando > maxKids* (iNadando-1)){
            log.waitingToRest();
            wait();
        }
        iWaiting--;
        iNadando--;
        nNadadores--;
        notifyAll();
        log.resting(); 
    }
}
