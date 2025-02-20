TekstFelt test;

void setup(){
    size(800,800);

    test = new TekstFelt(this,200,200,300,50);
}

void draw(){
    background(200);
    test.runDisplay();
}

void keyPressed(){
    test.runKeys();
}

