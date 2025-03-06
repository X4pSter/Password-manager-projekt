import processing.core.*;

public class Forside{

    private PApplet p;

    private Knap LogIn;
    private TekstFelt tekstFelt1;
    
    public Forside(PApplet p, Knap li, TekstFelt t1){
        this.p = p;
        LogIn = li;
        tekstFelt1 = t1;
    }

    public void runDisplay(){
        tekstFelt1.runDisplay();
        LogIn.runDisplay();
    }

    public void runKeys(){
        tekstFelt1.runKeys();
    }
    public void runMouse(){
        LogIn.mouseClickDetection();
    }
}