import processing.core.*;

public class TekstFeltObf {

    private PApplet p;

    private String tekst = "";

    private String displayedTekst = "";

    private float w, h, sw;

    private float x,y;

    private String titel = "";

    private boolean Click = false;

    private boolean obfuscation = true;

    private int R=100, G=100, B=100;

    public TekstFeltObf(PApplet p, float x, float y, float w, float h, String titel){
        this.p = p;

        this.x = x;

        this.y = y;

        this.w = w;

        sw = w;

        this.h = h;

        this.titel = titel;
    }

    public void mouseClickDetection(){
        if(p.mouseX < x + w/2 && p.mouseX > x-w/2 && p.mouseY < y + h && p.mouseY > y){
            Click = true;
            R=3;
            G=102;
            B=214;
            
        }else{
            Click=false;
            R=100;
            G=100;
            B=100;
        }
    }



    private void handleCharacter(){
        
        if(Click==true){
            
        if(p.key != p.CODED && p.keyCode != p.ENTER && p.keyCode != p.RETURN){
            tekst += p.str(p.key);
            if(obfuscation){displayedTekst += "*";}
            else{displayedTekst = tekst;}
        }
        if(p.key == p.BACKSPACE){
            if(tekst.length() > 1){
                tekst = tekst.substring(0,tekst.length() - 2);
                displayedTekst = displayedTekst.substring(0,displayedTekst.length() - 2);
            } else{
                tekst = "";
                displayedTekst = "";
            }
        }
            
    }

    }

    private void display(){
        p.rectMode(p.CORNER);

        p.fill(29,33,37);
        
        p.strokeWeight(1);
        p.stroke(R,G,B);

        p.rect(x-w/2,y,w,50,5);

        p.fill(255);

        p.textAlign(p.LEFT,p.CENTER);

        p.text(displayedTekst,x-w/2+5,y+25);

        p.textSize(15);
        p.fill(150);
        p.textAlign(p.LEFT);
        p.text(titel,p.width/2-150,y-15);
    }

    public void setTekst(String t){
        tekst = t;
        displayedTekst = "";
        for(int i = 0; i < tekst.length(); i++){
            displayedTekst += "*";
        }
    }

    public String getTekst(){
        return(tekst);
    }
    
    public void runDisplay(){
        display();
        p.textSize(25);
    }

    public void runKeys(){
        handleCharacter();
    }
    
    public void resetTekst(){
        tekst = "";
        displayedTekst = "";
    }

    public void changeObfuscation(){
        if(obfuscation){
            obfuscation = false;

            displayedTekst = tekst;
        } else if(!obfuscation){
            obfuscation = true;
            
            displayedTekst = "";

            for(int i = 0; i < tekst.length(); i++){
                displayedTekst += "*";
            }
        }
    }
}
