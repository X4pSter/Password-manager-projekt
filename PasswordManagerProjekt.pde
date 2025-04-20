import java.io.File;

TekstFelt webnavn,brugernavn,webKode;
TekstFeltObf kode;
Knap LogInd, reset,tilføj,anuller,godkend,LogAf,tilbageKnap,editFelt,kopier,sletData;
Knap WipeYes, WipeNo;

Kodedata[] kodedata = new Kodedata[100];

TekstFelt newPassword;
Knap setNewPassword;

String AddKodeTekst = "Tilføj data";

String SeKodeTekst = "Se data";

//Sider
Forside forside;
Homescreen homescreen;
AddKodeSide addkodeside,sekodeside;

//Kryptering
RandomString test2;
String testString;
int hr = 128, hg = 183, hb = 245;
int cr = 3, cg = 102, cb = 214;
Boolean TrykReset;
RandomString rand = new RandomString();
AES test = new AES();
JSONObject pw,s;
JSONArray db;
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
String key;
int attempts;
int kodedataSize = 0;
int KodeNummer = 2;
boolean EditKode = false;

int count;

int scrolle;

CopyToClipboard copyToClipboard;



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
    sletData = new Knap(this, width/2-200, height-125,200,50,"Slet Kodeord","sletData",235,3,3,cr,cg,cb);
    godkend = new Knap(this, width/2+200, height-125,200,50,"Godkend","Data",hr,hg,hb,cr,cg,cb);
    kopier = new Knap(this, width/2-230, height-230,140,30,"Kopier Kodeord","kopierKode",hr,hg,hb,cr,cg,cb);
    editFelt = new Knap(this, width/2+200, height-125,200,50,"Redigere","Edit",hr,hg,hb,cr,cg,cb);


    webnavn = new TekstFelt(this,width/2,300,600,50,"Websted navn");
    brugernavn = new TekstFelt(this,width/2,400,600,50,"Brugernavn");
    webKode = new TekstFelt(this,width/2,500,600,50,"Kodeord");

    changeObfuscation = new Knap(this,width/2+200,355,70,40,"Vis kode","changeObfuscationFunc",100,100,100,0,0,0);
    tilføj = new Knap(this, width/2, 350,300,50,"Tilføj Password","NyData",hr,hg,hb,cr,cg,cb);
    LogAf = new Knap(this, 80, 30,100,50,"Log Af","Tilbage",hr,hg,hb,cr,cg,cb);

    homescreen = new Homescreen(this,tilføj, LogAf);


    addkodeside = new AddKodeSide(this,tilbageKnap,anuller,godkend,webnavn,brugernavn,webKode,AddKodeTekst,kopier);
    sekodeside = new AddKodeSide(this,tilbageKnap,sletData,editFelt,webnavn,brugernavn,webKode,SeKodeTekst,kopier);

    dbPath = new File(sketchPath("db.json"));

    copyToClipboard = new CopyToClipboard();

 
    if(dbPath.exists()){
        db = loadJSONArray("db.json");

        JSONObject tempObject = db.getJSONObject(1);
        
        String temp = tempObject.getString("Salt");

        if(temp == null){
            dbExisted = false;

            db = new JSONArray();

            saveJSONArray(db,"db.json");
        } else{
            dbExisted = true;

        
        }
    } else{
        dbExisted = false;

        db = new JSONArray();

        saveJSONArray(db,"db.json");
    }

    loadCorrectButtons(dbExisted);
    //db.setJSONObject(0,pw);

    sletData();
    
}

void mouseWheel(MouseEvent event) {
    if(Side == 1){
        scrolle = event.getCount() + scrolle;
        println(scrolle);

        if(scrolle <= 0){
            scrolle = 0;
        }
    }
  
}

void draw(){
    background(#24292e);

    if(Side==0){
        forside.runDisplay();
        textSize(25);
    }

    if(Side == 1 && passwordMatch==true){
          
        

        for(int i = 2; i < db.size(); i++){
            if (i < kodedata.length) {  // Ensure we do not exceed array size
            JSONArray dbi = db.getJSONArray(i);
            JSONObject dbii = dbi.getJSONObject(0);
            kodedata[i] = new Kodedata(this, width / 2, i*60 + 300 - scrolle*4, dbii.getString("Name"), "SeData"); 
            kodedata[i].runDisplay();
            }
            
        }       

        noStroke();
        fill(36,41,46);
        rect(0, 0, 800, 410);

        homescreen.runDisplay(); 

    } else  if(Side == 2 && passwordMatch==true){
        addkodeside.runDisplay();
        textSize(25);

    }
    else if(Side == 3 && passwordMatch == true){
        sekodeside.runDisplay();
        textSize(25);
    }
    else{Side=0;}

    if(TrykReset == true){
        forside.DataWipe();

    }

    if(!passwordMatch && attempts >= 1){
        forside.forkertKode();
    }
}

void keyPressed(){
    if(Side==0){forside.runKeys();}
    if(Side==2){addkodeside.runKeys();}
}

void mousePressed(){
    if(Side==0){
        forside.runMouse();

        if(TrykReset == true){
            forside.WipeDataMouse();
        }
    }
    
    if(Side==1){

        homescreen.runMouse();

        for(int i = 2; i < db.size(); i++){
            if (i < kodedata.length) {  // Ensure we do not exceed array size
            JSONArray dbi = db.getJSONArray(i);
            JSONObject dbii = dbi.getJSONObject(0);
            kodedata[i] = new Kodedata(this, width / 2, i*60 + 300 - scrolle*4, dbii.getString("Name"), "SeData"); 
            
            if (kodedata[i].mouseClickDetection() && count >= 1) {
                KodeNummer =i;
                SeData(); 
            }
        }
        count++;

        }
        }
    if(Side==2){
        addkodeside.runMouse();
        addkodeside.runMouseFelt();
        }
    if(Side == 3){sekodeside.runMouse();}
    
}

void getPassword(){
    String passwordTemp = kode.getTekst();

    JSONObject tempObject = db.getJSONObject(1);

    String dbSalt = tempObject.getString("Salt");

    String saltTemp = aes.decrypt(dbSalt,passwordTemp,passwordTemp);

    String hashyPassword = hash.hashString(passwordTemp,saltTemp);

    String encryptyPassword = aes.encrypt(hashyPassword,hashyPassword,saltTemp);

    JSONObject tempObject2 = db.getJSONObject(0);

    String temp = tempObject2.getString("Password");

    passwordMatch = temp.equals(encryptyPassword);

    if(passwordMatch){
        count = 0;

        Side = 1;

        key = hashyPassword;
    }

    attempts++;
}

void newPassword(){
    db = new JSONArray();

    String passwordTemp = kode.getTekst();

    String saltTemp = saltGen.genRandString(20);

    String hashedTemp = hash.hashString(passwordTemp, saltTemp);

    String encryptedTemp = aes.encrypt(hashedTemp,hashedTemp,saltTemp);

    String encryptedSalt = aes.encrypt(saltTemp,passwordTemp,passwordTemp);

    JSONObject password = new JSONObject();
    password.setString("Password",encryptedTemp);
    db.setJSONObject(0,password);

    JSONObject salt = new JSONObject();
    salt.setString("Salt",encryptedSalt);
    db.setJSONObject(1,salt);

    saveJSONArray(db,"db.json");

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
    if(Side ==3){Side = 1;}else if(Side <= 2){Side --;}else{Side = 0;}
    TrykReset = false;
    kode.resetTekst();
    addkodeside.resetTekst();
}

void sletData(){
    for(int i = KodeNummer; i < db.size(); i++){
        if(i + 1 == db.size()){
            db.remove(i);
            break;
        }
        db.setJSONArray(i,db.getJSONArray(i+1));
    }
    saveJSONArray(db,"db.json");
    Tilbage();
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

void Data(){
    

    println("side nummer" + Side);
    JSONArray newService = new JSONArray();

    JSONObject name = new JSONObject();
    name.setString("Name",webnavn.getTekst());
    newService.setJSONObject(0,name);

    JSONObject username = new JSONObject();
    username.setString("Username",brugernavn.getTekst());
    newService.setJSONObject(1,username);

    JSONObject password = new JSONObject();
    RandomString newSaltGen = new RandomString();
    String newSalt = newSaltGen.genRandString(20);
    password.setString("Password",aes.encrypt(webKode.getTekst(),key,newSalt));
    newService.setJSONObject(2,password);

    JSONObject salt = new JSONObject();
    salt.setString("Salt",aes.encrypt(newSalt,key,key));
    newService.setJSONObject(3,salt);

    if(EditKode == false){
    int repetitions = 0;

    boolean empty = db.isNull(repetitions);

    println(empty);

    while(!empty){
        println(repetitions);
        empty = db.isNull(repetitions);
        if(empty){
            break;
        }
        println(empty);
        repetitions++;
    }

    println(repetitions);

    if(empty){
        db.setJSONArray(repetitions,newService);

        saveJSONArray(db,"db.json");
    }
    Side = 1;
    addkodeside.resetTekst();
    }
    else if(EditKode == true){
        db.setJSONArray(KodeNummer,newService);
        Side = 1;
        addkodeside.resetTekst();
        saveJSONArray(db,"db.json");
        EditKode = false;
    }

    
}

void SeData(){

    Side = 3;
    JSONArray dbj = db.getJSONArray(KodeNummer);

    JSONObject dbN = dbj.getJSONObject(0);
    webnavn.setTekst(dbN.getString("Name"));

    JSONObject dbB = dbj.getJSONObject(1);
    brugernavn.setTekst(dbB.getString("Username"));

    JSONObject dbP = dbj.getJSONObject(2);
    JSONObject salt = dbj.getJSONObject(3);
    String passwordSalt = aes.decrypt(salt.getString("Salt"),key,key);
    String temp = aes.decrypt(dbP.getString("Password"),key,passwordSalt);
    webKode.setTekst(temp);
}

void Edit(){
    EditKode = true;
    Side = 2;
}

void kopierKode(){
    copyToClipboard.copy(webKode.getTekst());
}


