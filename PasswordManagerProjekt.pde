import java.io.*;

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
JSONObject db,pw,s;
RandomString saltGen = new RandomString();
String salt;
AES aes = new AES();
Hash512 hash = new Hash512();
boolean passwordMatch = false;
String hashedTemp;
File dbCheck = new File("C:\\GitHub_repositories\\Passwordmanagerprojekt\\db.json");
int Side = 0;
TekstFelt newPassword;
Knap setNewPassword;
String test69 = "Very Secure Password";

void setup(){
    size(800,800);

    salt = saltGen.genRandString(20);
    
    kode = new TekstFelt(this,width/2,350,300,50,"Kodeord");
    LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","getPassword",hr,hg,hb,cr,cg,cb);
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);
    WipeYes = new Knap(this, width/2+100, height/2+100,100,50,"Ja","WipeDatabase",235,3,3,cr,cg,cb);
    WipeNo = new Knap(this, width/2-100, height/2+100,100,50,"Nej","Tilbage",7, 250, 2,cr,cg,cb);

    forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo);

    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);

    homescreen = new Homescreen(this,tilføj, LogAf);

    newPassword = new TekstFelt(this, 100, 100, 100, 100, "Indtast nyt kodeord");
    setNewPassword = new Knap(this, 200, 100, 100, 100, "ting", "NewPassword",100,100,100,100,100,100);

    if(dbCheck.exists()){
        db = loadJSONObject("db.json");
    } else{
        db = new JSONObject();

        saveJSONObject(db,"db.json");
    }
}

void draw(){
    background(#24292e);

    if(Side==0){
        forside.runDisplay();
        textSize(25);
    }

    if(Side == 1 ){ //&& passwordMatch==true
        homescreen.runDisplay();
    } else{Side=0;}

    if(TrykReset == true){
        forside.DataWipe();

    }

    setNewPassword.runDisplay();

}

void keyPressed(){
    if(Side==0){forside.runKeys();}
}

void mousePressed(){
    if(Side==0){forside.runMouse();}
    if(Side==1){homescreen.runMouse();}
    setNewPassword.mouseClickDetection();
}

void getPassword(){
    //println("test forside");

    String test70 = kode.getTekst();

    String passwordTemp = kode.getTekst();

    println(test70);

    println(passwordTemp);

    String dbSalt = db.getString("Salt");

    String saltTemp = aes.decrypt(dbSalt,passwordTemp,passwordTemp);

    String saltyPassword = passwordTemp + saltTemp;
    String hashyPassword = hash.encryptThisString(saltyPassword);

    String encryptyPassword = aes.encrypt(hashyPassword,hashyPassword,saltTemp);
    
    println(encryptyPassword);

    String temp = db.getString("Password");

    passwordMatch = temp.equals(encryptyPassword);
    println(passwordMatch);
    
    // Side = 1;
 

}

void NewPassword(){
    db = new JSONObject();

    //String passwordTemp = newPassword.getTekst();

    String passwordTemp = test69;

    String saltTemp = saltGen.genRandString(20);

    String hashedTemp = hash.hashString(passwordTemp, saltTemp);

    String encryptedTemp = aes.encrypt(hashedTemp,hashedTemp,saltTemp);

    String encryptedSalt = aes.encrypt(saltTemp,passwordTemp,passwordTemp);

    db.setString("Password", encryptedTemp);

    db.setString("Salt", encryptedSalt);

    saveJSONObject(db,"db.json");
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