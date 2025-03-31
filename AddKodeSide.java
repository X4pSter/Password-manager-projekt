import processing.core.*;

public class AddKodeSide{

    private PApplet p;

    private Knap tilbage;

    private TekstFelt webnavn;

    public String tekst;
    
    public AddKodeSide(PApplet p, Knap tb, TekstFelt wn, String tk){
        this.p = p;
        tilbage = tb;
        webnavn = wn;
        tekst = tk;
    }

    public void runDisplay(){
        tilbage.runDisplay();

        p.fill(48, 54, 61);
        p.strokeWeight(1);
        p.stroke(3,102,214);
        p.rect(p.width/2-350,p.height/2-180,700,530,5);

        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text(tekst,p.width/2,170);
        
        p.textSize(25);
        webnavn.runDisplay();


    }

    public void runMouse(){
        tilbage.mouseClickDetection();
        webnavn.mouseClickDetection();
        
    }

    public void runKeys(){
        webnavn.runKeys();
    }

}