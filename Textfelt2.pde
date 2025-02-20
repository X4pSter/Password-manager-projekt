class TekstFelt2{

    String tekst = "";

    boolean check;

    TekstFelt2(){
 
    }

    void handleCharacters(){
        if(key != CODED && keyCode != ENTER && keyCode != RETURN){
            tekst += str(key);
        }
        if(key == BACKSPACE){
            if(tekst.length() > 1){
                tekst = tekst.substring(0,tekst.length() - 2);
                println(tekst);
            } else{
                tekst = "";
                println(tekst);
            }
            
        }
    }

    void display(){
      textSize(40);
      rectMode(CENTER);
      fill(255);
      rect(width/2,150,300,50,5);
      fill(0);
      textAlign(LEFT,CENTER);
      text(tekst,width/2-145,155);
      strokeWeight(2);
      stroke(0);
      
    }

    void setTekst(String t){
        tekst = t;
    }

    String getTekst(){
        return(tekst);
    }

    void runDisplay(){
        display();
    }

    void runKeys(){
        handleCharacters();
    }
}
