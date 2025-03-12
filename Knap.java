import processing.core.*;
public class Knap{
    private PApplet p;
    private int x, y,b,h;
    private String titel;
    private String action;
    private int hr,hg,hb;
    private int cr, cg, cb;

    public Knap(PApplet p, int xin, int yin, int bin, int hin, String titelin, String actionin, int hrin, int hgin, int hbin, int crin, int cgin, int cbin){
      this.p = p;
      x = xin; 
      y = yin; 
      b = bin; 
      h = hin;
      titel = titelin; 
      action = actionin;
      hr = hrin;
      hg = hgin;
      hb = hbin;
      cr = crin;
      cg = cgin;
      cb = cbin;
      
      

    }

    private void display(){
        if(p.mouseX < x + b/2 && p.mouseX > x-b/2 && p.mouseY < y + h && p.mouseY > y){
         p.fill(hr,hg,hb);
        } 
        else {
          p.fill(cr,cg,cb);
        }
        p.noStroke();
        p.rect(x-b/2,y,b,h,25);

        p.textAlign(p.LEFT);
        p.fill(255);
        p.textSize(15);
        float w = p.textWidth(titel);
        p.text(titel,x-b/2 + b/2 - w/2,y + h/2 + 5);
        
        
    
      }
      
      public void mouseClickDetection(){
       if(p.mouseX < x + b/2 && p.mouseX > x-b/2 && p.mouseY < y + h && p.mouseY > y){
         p.method(action);
       }
      }
    
      public void runDisplay(){
        display();
      }


}
