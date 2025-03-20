import processing.core.*;

public class Homescreen{

    private PApplet p;

    private Knap tilføj, LogAf;
    private Knap WipeYes, WipeNo;
    
    public Homescreen(PApplet p, Knap til, Knap la){
        this.p = p;
        tilføj = til;
        LogAf = la;
    }

    public void runDisplay(){
        tilføj.runDisplay();
        LogAf.runDisplay();
        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text("Passwords",p.width/2,270);

    }

    public void runMouse(){
        tilføj.mouseClickDetection();
        LogAf.mouseClickDetection();
        
    }

}