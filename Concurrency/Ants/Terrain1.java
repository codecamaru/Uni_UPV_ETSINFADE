import java.util.concurrent.locks.*;
/**
 * Write a description of class Terrain1 here.
 * 
 * @author CM 
 * @version (a version number or a date)
 */
public class Terrain1 implements Terrain
{
    Viewer v;
    Lock mutex;
    Condition cond;
    public  Terrain1 (int t, int ants, int movs, String msg) {
        v=new Viewer(t,ants,movs,msg);
        mutex = new ReentrantLock();
        cond = mutex.newCondition();
    }
    public void     hi      (int a) {
        mutex.lock();
        try{v.hi(a);}   
        finally{ mutex.unlock(); }
    }
    public void     bye     (int a) {
        mutex.lock();
        try{cond.signalAll();v.bye(a); }   
        finally{ mutex.unlock(); }
    }
    public void     move    (int a) throws InterruptedException {
        mutex.lock();
        try{
        v.turn(a); Pos dest=v.dest(a); 
        while (v.occupied(dest)) {
            cond.await(); v.retry(a);}
        v.go(a); cond.signalAll();
        }
        finally{ mutex.unlock(); }
    }
}
