// CSD feb 2015 Juansa Sendra

public class Pool1 extends Pool {   //no kids alone
    private int iNadando = 0;
    private int nNadando = 0;
    public void init(int ki, int cap)           {}
    public synchronized void kidSwims() throws InterruptedException {
        while (iNadando == 0) { //COMPLETAR la condición
         log.waitingToSwim();//para visualizar la posición del nadador
         wait();
     }
     nNadando++;//Actualiza estado (COMPLETAR)
     //Si necesario, avisa del nuevo estado a otros hilos
     // con notifyAll();
     log.swimming(); //para visualizar la posición del nadador
     }
    public synchronized void kidRests()      {
        nNadando--;
        notifyAll();
        log.resting(); 
    }
    public synchronized void instructorSwims()   {
        iNadando++;
        notifyAll();
        log.swimming();
    }
    public synchronized void instructorRests() throws InterruptedException {
        while(nNadando > 0 && iNadando==1){
            log.waitingToRest();
            wait();
        }
        iNadando--;
        log.resting(); 
    }
}
