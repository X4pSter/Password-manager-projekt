import processing.core.*;

public class TekstFelt {

    private PApplet p;

    private String tekst = "";

    private float w, h, sw;

    private float x,y;

    public TekstFelt(PApplet p, float x, float y, float w, float h){
        this.p = p;

        this.x = x;

        this.y = y;

        this.w = w;

        sw = w;

        this.h = h;
    }

    private void handleCharacter(){
        if(p.key != p.CODED && p.keyCode != p.ENTER && p.keyCode != p.RETURN){
            tekst += p.str(p.key);
        }
        if(p.key == p.BACKSPACE){
            if(tekst.length() > 1){
                tekst = tekst.substring(0,tekst.length() - 2);
                p.println(tekst);
            } else{
                tekst = "";
                p.println(tekst);
            }
            
        }

    }

    private void display(){
        w = p.textWidth(tekst + "w");
          
        if(w < sw){
           w = sw;
        }
        p.textSize(40);

        p.rectMode(p.CORNER);

        p.fill(255);
        
        p.strokeWeight(2);
        p.stroke(0);

        p.rect(p.width/2-150,150,w,50,5);

        p.fill(0);

        p.textAlign(p.LEFT,p.CENTER);

        p.text(tekst,p.width/2-145,173);

        
        
    }

    public void setTekst(String t){
        tekst = t;
    }

    public String getTekst(){
        return(tekst);
    }
    
    public void runDisplay(){
        display();
    }

    public void runKeys(){
        handleCharacter();
    }
}
