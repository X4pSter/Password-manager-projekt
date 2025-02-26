import processing.core.*;
public class Knap{
    private PApplet p;
    private int x, y,b,h;
    private String titel;
    private int rectColor, rectHighlight;
    private String action;
    
    public knap(PApplet p, int xin, int yin, int bin, int hin, String titelin, String actionin){
      this.p = p;
      x = xin; 
      y = yin; 
      b = bin; 
      h = hin;
      titel = titelin; 
      action = actionin;
      rectColor = 200;
      rectHighlight = 100; 
    }

    public void display(){
        if(p.mouseX < x + b && p.mouseX > x && p.mouseY < y + h && p.mouseY > y){
         fill(rectHighlight);
        } 
        else {
          fill(rectColor);
        }
        noStroke();
        rect(x,y,b,h,25);

        textAlign(p.LEFT);
        fill(50);
        textSize(15);
        float w = textWidth(titel);
        text(titel,x + b/2 - w/2,y + h/2 + 5);
        
    
      }
      
      private void mouseClickDetection(){
       if(p.mouseX < x + b && p.mouseX > x && p.mouseY < y + h && p.mouseY > y){
         method(action);
       }
      }
    


}
