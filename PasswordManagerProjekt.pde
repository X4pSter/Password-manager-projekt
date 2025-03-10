TekstFelt kode;
Knap LogInd;
Forside forside;
RandomString test2;
String testString;

void setup(){
    size(800,800);
    
    kode = new TekstFelt(this,300,350,300,50,"Kodeord");
    LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","TestKnap");

    forside = new Forside(this, LogInd, kode);

    test2 = new RandomString();

    testString = test2.genRandString(20);

    println(testString);
}

void draw(){
    background(#24292e);
    forside.runDisplay();
    textSize(25);
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

