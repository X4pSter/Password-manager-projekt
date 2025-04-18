import processing.core.*;

public class AddKodeSide{

    private PApplet p;

    private Knap tilbage,anuller,godkend;

    private TekstFelt webnavn,brugernavn,kodeord;

    public String tekst;
    
    public AddKodeSide(PApplet p, Knap tb, Knap an, Knap gk, TekstFelt wn,TekstFelt bn,TekstFelt ko, String tk){
        this.p = p;
        tilbage = tb;
        anuller = an;
        godkend = gk;
        webnavn = wn;
        brugernavn = bn;
        kodeord = ko;
        tekst = tk;
    }

    public void runDisplay(){
        tilbage.runDisplay();

        p.fill(48, 54, 61);
        p.strokeWeight(1);
        p.stroke(3,102,214);
        p.rect(p.width/2-350,p.height/2-180,700,400,5);

        
        p.textSize(50);
        p.fill(255);
        p.textAlign(p.CENTER);
        p.text(tekst,p.width/2,170);
        
        p.textSize(25);
        webnavn.runDisplay();
        brugernavn.runDisplay();
        kodeord.runDisplay();


        anuller.runDisplay();
        godkend.runDisplay();

    }

    public void runMouse(){
        tilbage.mouseClickDetection();
        anuller.mouseClickDetection();
        godkend.mouseClickDetection();
    
        
    }
    public void runMouseFelt(){
        webnavn.mouseClickDetection();
        brugernavn.mouseClickDetection();
        kodeord.mouseClickDetection();
     
    }

    public void runKeys(){
        webnavn.runKeys();
        brugernavn.runKeys();
        kodeord.runKeys();
        
    }

    public void resetTekst(){
        webnavn.resetTekst();
        brugernavn.resetTekst();
        kodeord.resetTekst();

    }
    

}