import processing.core.*;
public class Knap{
    private PApplet p;
    private int x, y,b,h;
    private String titel;
    private int rectColor, rectHighlight;
    private String action;

    public Knap(PApplet p, int xin, int yin, int bin, int hin, String titelin, String actionin){
      this.p = p;
      x = xin; 
      y = yin; 
      b = bin; 
      h = hin;
      titel = titelin; 
      action = actionin;
      rectColor = 250;
      rectHighlight = 100; 
    }

    private void display(){
        if(p.mouseX < x + b/2 && p.mouseX > x-b/2 && p.mouseY < y + h && p.mouseY > y){
         p.fill(rectHighlight);
        } 
        else {
          p.fill(rectColor);
        }
        p.noStroke();
        p.rect(x-b/2,y,b,h,25);

        p.textAlign(p.LEFT);
        p.fill(50);
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
