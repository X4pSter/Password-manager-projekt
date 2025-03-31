import processing.core.*;

public class TekstFelt {

    private PApplet p;

    private String tekst = "";

    private float w, h, sw;

    private float x,y;

    private String titel = "";

    private boolean Click = false;

    private int R=100, G=100, B=100;

    public TekstFelt(PApplet p, float x, float y, float w, float h, String titel){
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

    }

    private void display(){
        w = p.textWidth(tekst + "w");
          
        if(w < sw){
           w = sw;

        }

        p.rectMode(p.CORNER);

        p.fill(29,33,37);
        
        p.strokeWeight(1);
        p.stroke(R,G,B);

        p.rect(x-w/2,y,w,50,5);

        p.fill(255);

        p.textAlign(p.LEFT,p.CENTER);

        p.text(tekst,x-w/2+5,y+25);

        p.textSize(15);
        p.fill(150);
        p.textAlign(p.LEFT);
        p.text(titel,x-w/2+5,y-15);



        
        
    }

    public void setTekst(String t){
        tekst = t;
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
    }
}
