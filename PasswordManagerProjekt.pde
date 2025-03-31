import java.io.File;

TekstFelt webnavn,brugernavn,webKode,url,note;
TekstFeltObf kode;
Knap LogInd, reset,tilføj,anuller,godkend,LogAf,tilbageKnap;
Knap WipeYes, WipeNo;

TekstFelt newPassword;
Knap setNewPassword;
String AddKodeTekst = "Tilføj data";

//Sider
Forside forside;
Homescreen homescreen;
AddKodeSide addkodeside;

//Kryptering
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
//String test69 = "Very Secure Password";
boolean dbExisted;
Knap changeObfuscation;

void setup(){
    size(800,800);

    TrykReset = false;
    
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);
    WipeYes = new Knap(this, width/2+100, height/2+100,100,50,"Ja","WipeDatabase",235,3,3,cr,cg,cb);
    WipeNo = new Knap(this, width/2-100, height/2+100,100,50,"Nej","Tilbage",7, 250, 2,cr,cg,cb);

    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);
    tilbageKnap = new Knap(this, 80, 30,100,50,"Tilbage","Tilbage",hr,hg,hb,cr,cg,cb);
    anuller = new Knap(this, width/2-200, height-125,200,50,"Anuller","Tilbage",hr,hg,hb,cr,cg,cb);
    godkend = new Knap(this, width/2+200, height-125,200,50,"Godkend","Data",hr,hg,hb,cr,cg,cb);


    webnavn = new TekstFelt(this,width/2-155,300,300,50,"Websted navn");
    brugernavn = new TekstFelt(this,width/2-155,400,300,50,"Brugernavn");
    webKode = new TekstFelt(this,width/2-155,500,300,50,"Kodeord");
    url = new TekstFelt(this,width/2+155,400,300,50,"URL");
    note = new TekstFelt(this,width/2+155,500,300,50,"Note");

    changeObfuscation = new Knap(this,width/2+200,355,70,40,"Vis kode","changeObfuscationFunc",100,100,100,0,0,0);
    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);

    homescreen = new Homescreen(this,tilføj, LogAf);


    addkodeside = new AddKodeSide(this,tilbageKnap,anuller,godkend,webnavn,brugernavn,webKode,url,note,AddKodeTekst);

    dbPath = new File(sketchPath("db.json"));

    if(dbPath.exists()){
        db = loadJSONObject("db.json");

        String temp = db.getString("Salt");

        if(temp == null){
            dbExisted = false;

            db = new JSONObject();

            saveJSONObject(db,"db.json");
        } else{
            dbExisted = true;
        }
    } else{
        dbExisted = false;

        db = new JSONObject();

        saveJSONObject(db,"db.json");
    }

    loadCorrectButtons(dbExisted);
    //db.setJSONObject(0,pw);
    
}

void draw(){
    background(#24292e);

    if(Side==0){
        forside.runDisplay();
        textSize(25);
    }

    if(Side == 1 && passwordMatch==true){
        homescreen.runDisplay();
    } else  if(Side == 2){
        addkodeside.runDisplay();
        textSize(25);
    } else{Side=0;}

    if(TrykReset == true){
        forside.DataWipe();

    }
}

void keyPressed(){
    if(Side==0){forside.runKeys();}
    if(Side==2){addkodeside.runKeys();}
}

void mousePressed(){
    if(Side==0){forside.runMouse();}
    if(Side==1){homescreen.runMouse();}
    if(Side==2){addkodeside.runMouse();}
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

    if(passwordMatch){
        Side = 1;
    }
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

    dbExisted = true;

    loadCorrectButtons(dbExisted);

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
    if(Side <= 2){Side --;}else{Side = 0;}
    TrykReset = false;
    kode.resetTekst();
    addkodeside.resetTekst();
}


void NyData(){
    Side = 2;
}

void loadCorrectButtons(boolean b){
    if(!b){
        LogInd = new Knap(this, width/2, 420,300,50,"Indstil nyt Kodeord","newPassword",hr,hg,hb,cr,cg,cb);

        kode = new TekstFeltObf(this,width/2,350,300,50,"Indtast nyt Kodeord");

        forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo,changeObfuscation);
    } else{
        kode = new TekstFeltObf(this,width/2,350,300,50,"Kodeord");

        LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","getPassword",hr,hg,hb,cr,cg,cb);

        forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo,changeObfuscation);
    }
}

void changeObfuscationFunc(){
    kode.changeObfuscation();
}