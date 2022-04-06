// CSD Mar 2013 Juansa Sendra

public class LimitedTable extends RegularTable implements Table{ //max 4 in dinning-room
    private int nfil = 0;
    public LimitedTable(StateManager state) {super(state);}
    public synchronized void enter(int id) throws InterruptedException {
        while(nfil >= 4){
            state.wenter(id); 
            wait();
        }
        nfil++;
        state.enter(id);
    }
    public synchronized void exit(int id)  {
        nfil--;
        notifyAll();
        state.exit(id);
    }
}
