TekstFelt test;
Knap knap;

void setup(){
    size(800,800);

    test = new TekstFelt(this,200,200,300,50);
    knap = new Knap(this, width/2, 650,100,50,"Knap","TestKnap");
}

void draw(){
    background(200);
    test.runDisplay();
    knap.runDisplay();
}

void keyPressed(){
    test.runKeys();
}

void mousePressed(){
    knap.mouseClickDetection();

}

void TestKnap(){
    println("test");
}

