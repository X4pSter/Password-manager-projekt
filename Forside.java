import processing.core.*;

public class Forside{

    private PApplet p;

    private Knap LogIn, reset;
    private Knap WipeYes, WipeNo;
    private TekstFelt tekstFelt1;
    private String LI = "Log Ind";
    
    public Forside(PApplet p, Knap li, Knap re,TekstFelt t1,Knap WY, Knap WN){
        this.p = p;
        LogIn = li;
        reset = re;
        tekstFelt1 = t1;
        WipeYes = WY;
        WipeNo = WN;
    }

    public void runDisplay(){
        tekstFelt1.runDisplay();
        LogIn.runDisplay();
        reset.runDisplay();
        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text(LI,p.width/2,270);

    }

    public void runKeys(){
        tekstFelt1.runKeys();
    }
    public void runMouse(){
        LogIn.mouseClickDetection();
        reset.mouseClickDetection();

        WipeYes.mouseClickDetection();
        WipeNo.mouseClickDetection();

        tekstFelt1.mouseClickDetection();
    
        
    }

    public void DataWipe(){
        
        
        p.fill(48, 54, 61);
        p.strokeWeight(1);
        p.stroke(3,102,214);
        p.rect(p.width/2-250,p.height/2-175,500,350,5);

        p.textAlign(p.CENTER);
        p.textSize(30);
        p.fill(255);
        p.text("Ønsker du at slette alt data?",p.width/2,p.height/2-30);

        p.textSize(20);
        p.fill(255);
        p.text("Slettet data kan ikke genoprettes.",p.width/2,p.height/2+20);
        WipeYes.runDisplay();
        WipeNo.runDisplay();
    }
}