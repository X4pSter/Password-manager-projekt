
import processing.core.*;

public class Kodedata{

    private PApplet p;
    private int y;
    private String titel;
    private String action;
    private int b = 300;
    private int h = 50;
    private int x;

    private boolean clicked = false;


    public Kodedata(PApplet p, int xin, int yin, String titelin, String actionin){
      this.p = p;
      x = xin;
      y = yin; 
      titel = titelin; 
      action = actionin;
    }


    private void display(){
        if(p.mouseX < x + b/2 && p.mouseX > x-b/2 && p.mouseY < y + h && p.mouseY > y){
         p.fill(100,100,100);
        } 
        else {
          p.fill(29,33,37);
        }
        p.noStroke();
        p.rect(x-b/2,y,b,h,5);

        p.textAlign(p.LEFT);
        p.fill(255);
        p.textSize(15);
        float w = p.textWidth(titel);
        p.text(titel,x-b/2 + b/2 - w/2,y + h/2 + 5);
        
        
    
      }
      
      public boolean mouseClickDetection(){
       if(p.mouseX < x + b/2 && p.mouseX > x-b/2 && p.mouseY < y + h && p.mouseY > y){
        clicked = false;
        return true;
       }
       return false;
      }
    
      public void runDisplay(){
        display();
      }


}