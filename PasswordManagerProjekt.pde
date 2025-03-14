TekstFelt kode;
Knap LogInd, reset;
Forside forside;
RandomString test2;
String testString;
int hr = 128, hg = 183, hb = 245;
int cr = 3, cg = 102, cb = 214;
Boolean TrykReset = false;
RandomString test3 = new RandomString();
AES test = new AES("very very secret key", test3.genRandString(20));


void setup(){
    size(800,800);
    
    kode = new TekstFelt(this,300,350,300,50,"Kodeord");
    LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","TestKnap",hr,hg,hb,cr,cg,cb);
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);

    forside = new Forside(this, LogInd, reset, kode);

    test2 = new RandomString();

    testString = test2.genRandString(20);

    println(testString);

    String temp = test.encrypt(testString);

    String temp2 = test.decrypt(temp);

    println(temp2);

    println(temp2.length());
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

void ResetData(){
    println("test reset");
    TrykReset = true;
    println(TrykReset);
}


