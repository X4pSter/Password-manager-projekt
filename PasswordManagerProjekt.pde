import java.io.File;

TekstFelt kode;
Knap LogInd, reset,tilføj,LogAf;
Knap WipeYes, WipeNo;
Forside forside;
Homescreen homescreen;
RandomString test2;
String testString;
int hr = 128, hg = 183, hb = 245;
int cr = 3, cg = 102, cb = 214;
Boolean TrykReset = false;
RandomString rand = new RandomString();
AES test = new AES();
String password;
JSONObject db,pw,s;
RandomString saltGen = new RandomString();
String salt;
AES aes;
Hash512 hash = new Hash512();
Hash256 hash256 = new Hash256();
boolean passwordMatch = false;
String hashedTemp;
File dbCheck = new File("db.json");
int Side = 0;

void setup(){
    size(800,800);

    salt = saltGen.genRandString(20);
    
    kode = new TekstFelt(this,300,350,300,50,"Kodeord");
    LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","getPassword",hr,hg,hb,cr,cg,cb);
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);
    WipeYes = new Knap(this, width/2+100, height/2+100,100,50,"Ja","WipeDatabase",235,3,3,cr,cg,cb);
    WipeNo = new Knap(this, width/2-100, height/2+100,100,50,"Nej","Tilbage",7, 250, 2,cr,cg,cb);

    forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo);

    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);

    homescreen = new Homescreen(this,tilføj, LogAf);

    if(dbCheck.exists()){
        println("exists");

        db = loadJSONObject("db.json");
    } else{
        db = new JSONObject();

        db.setString("salt",rand.genRandString(20));

        saveJSONObject(db,"db.json");
    }
}

void draw(){
    background(#24292e);

    if(Side==0){
        forside.runDisplay();
        textSize(25);
    }

    if(Side == 1 && passwordMatch==true){
        homescreen.runDisplay();
    }else{Side=0;}

    if(TrykReset == true){
        forside.DataWipe();

    }

}

void keyPressed(){
    if(Side==0){forside.runKeys();}
}

void mousePressed(){
    if(Side==0){forside.runMouse();}
    if(Side==1){homescreen.runMouse();}

}

void getPassword(){
    
    
    println("test forside");
    password = kode.getTekst();
    println(password);

    String saltyPassword = password + salt;
    String hashyPassword = hash.encryptThisString(saltyPassword);

    JSONArray tempJA = loadJSONArray("db.json");
    JSONObject tempJO = tempJA.getJSONObject(0);

    String temp = tempJO.getString("password");
    String encryptyPassword = aes.encrypt(hashyPassword,hashyPassword,salt);
    println(encryptyPassword);

    passwordMatch = temp.equals(encryptyPassword);
    println(passwordMatch);
    
    // Side = 1;
 

}

void ResetData(){
    println("test reset");
    TrykReset = true;
    println("TrykReset = " + TrykReset);

}

void WipeDatabase(){
    
}

void Tilbage(){
    TrykReset = false;
    if(Side <= 1){Side --;}else{Side = 0;}
    kode.resetTekst();
}