
/**
 * Write a description of class Terrain3 here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Terrain3 implements Terrain
{
    Viewer v;
    public  Terrain3 (int t, int ants, int movs, String msg) {
        v=new Viewer(t,ants,movs,msg);
    }
    public synchronized void     hi      (int a) {v.hi(a);    }
    public synchronized void     bye     (int a) {notifyAll();v.bye(a);    }
    public synchronized void     move    (int a) throws InterruptedException {
        v.turn(a); Pos dest=v.dest(a); 
        while (v.occupied(dest)) {wait(); v.retry(a);}
        v.go(a); notifyAll();
    }
}
