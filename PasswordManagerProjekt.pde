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
Boolean TrykReset;
RandomString rand = new RandomString();
AES test = new AES();
JSONObject db,pw,s;
RandomString saltGen = new RandomString();
AES aes = new AES();
Hash512 hash = new Hash512();
boolean passwordMatch = false;
String hashedTemp;
File dbPath;
int Side = 0;
TekstFelt newPassword;
Knap setNewPassword;
//String test69 = "Very Secure Password";

void setup(){
    size(800,800);

    TrykReset = false;
    
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);
    WipeYes = new Knap(this, width/2+100, height/2+100,100,50,"Ja","WipeDatabase",235,3,3,cr,cg,cb);
    WipeNo = new Knap(this, width/2-100, height/2+100,100,50,"Nej","Tilbage",7, 250, 2,cr,cg,cb);

    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);

    homescreen = new Homescreen(this,tilføj, LogAf);

    dbPath = new File(sketchPath("db.json"));

    boolean dbExisted = false;

    if(dbPath.exists()){
        db = loadJSONObject("db.json");

        String temp = db.getString("Salt");

        if(temp == null){
            db = new JSONObject();

            saveJSONObject(db,"db.json");
        } else{
            dbExisted = true;
        }
    } else{
        db = new JSONObject();

        saveJSONObject(db,"db.json");
    }

    if(!dbExisted){
        LogInd = new Knap(this, width/2, 420,300,50,"Indstil nyt Kodeord","newPassword",hr,hg,hb,cr,cg,cb);

        kode = new TekstFelt(this,width/2,350,300,50,"Indtast nyt Kodeord");

        forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo);
    } else{
        kode = new TekstFelt(this,width/2,350,300,50,"Kodeord");

        LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","getPassword",hr,hg,hb,cr,cg,cb);

        forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo);
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
}

void keyPressed(){
    if(Side==0){forside.runKeys();}
}

void mousePressed(){
    if(Side==0){forside.runMouse();}
    if(Side==1){homescreen.runMouse();}
}

void getPassword(){
    String passwordTemp = kode.getTekst();

    String dbSalt = db.getString("Salt");

    String saltTemp = aes.decrypt(dbSalt,passwordTemp,passwordTemp);

    String saltyPassword = passwordTemp + saltTemp;
    String hashyPassword = hash.encryptThisString(saltyPassword);

    String encryptyPassword = aes.encrypt(hashyPassword,hashyPassword,saltTemp);

    String temp = db.getString("Password");

    passwordMatch = temp.equals(encryptyPassword);
    
    Side = 1;
}

void newPassword(){
    db = new JSONObject();

    String passwordTemp = kode.getTekst();

    String saltTemp = saltGen.genRandString(20);

    String hashedTemp = hash.hashString(passwordTemp, saltTemp);

    String encryptedTemp = aes.encrypt(hashedTemp,hashedTemp,saltTemp);

    String encryptedSalt = aes.encrypt(saltTemp,passwordTemp,passwordTemp);

    db.setString("Password", encryptedTemp);

    db.setString("Salt", encryptedSalt);

    saveJSONObject(db,"db.json");

    Side = 1;
}

void ResetData(){
    TrykReset = true;
}

void WipeDatabase(){
    dbPath.delete();
    setup();
}

void Tilbage(){
    TrykReset = false;
    if(Side <= 1){Side --;}else{Side = 0;}
    kode.resetTekst();
}