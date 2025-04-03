import processing.core.*;

public class Forside{

    private PApplet p;

    private Knap LogIn, reset;
    private Knap WipeYes, WipeNo;
    private Knap changeObfuscation;
    private TekstFeltObf tekstFeltObf;
    private String LI = "Log Ind";
    
    public Forside(PApplet p, Knap li, Knap re,TekstFeltObf tobf,Knap WY, Knap WN, Knap CO){
        this.p = p;
        LogIn = li;
        reset = re;
        tekstFeltObf = tobf;
        WipeYes = WY;
        WipeNo = WN;
        changeObfuscation = CO;
    }

    public void runDisplay(){
        tekstFeltObf.runDisplay();
        LogIn.runDisplay();
        reset.runDisplay();
        changeObfuscation.runDisplay();
        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text(LI,p.width/2,270);
    }

    public void runKeys(){
        tekstFeltObf.runKeys();
    }
    public void runMouse(){
        LogIn.mouseClickDetection();
        reset.mouseClickDetection();

        WipeYes.mouseClickDetection();
        WipeNo.mouseClickDetection();

        changeObfuscation.mouseClickDetection();

        tekstFeltObf.mouseClickDetection();
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

    public void forkertKode(){
        p.fill(255, 38, 23);
        p.textSize(20);
        p.text("Forkert kodeord, prøv igen", p.width/2,500);
    }
}