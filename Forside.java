import processing.core.*;

public class Forside{

    private PApplet p;

    private Knap LogIn;
    private TekstFelt tekstFelt1;
    private String li = "Log Ind";
    
    public Forside(PApplet p, Knap li, TekstFelt t1){
        this.p = p;
        LogIn = li;
        tekstFelt1 = t1;
    }

    public void runDisplay(){
        tekstFelt1.runDisplay();
        LogIn.runDisplay();
        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text(li,p.width/2,270);

    }

    public void runKeys(){
        tekstFelt1.runKeys();
    }
    public void runMouse(){
        LogIn.mouseClickDetection();
    }
}