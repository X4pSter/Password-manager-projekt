TekstFelt test;
Knap knap;
Forside forside;
RandomString test2;
String testString;

void setup(){
    size(800,800);
    
    test = new TekstFelt(this,200,200,300,50);
    knap = new Knap(this, width/2, 650,100,50,"Knap","TestKnap");

    forside = new Forside(this, knap, test);

    test2 = new RandomString();

    testString = test2.genRandString(20);

    println(testString);
}

void draw(){
    background(200);
    forside.runDisplay();
}

void keyPressed(){
    forside.runKeys();
}

void mousePressed(){
    forside.runMouse();

}

void TestKnap(){
    println("test forside");
}

