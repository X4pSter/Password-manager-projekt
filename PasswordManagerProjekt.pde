TekstFelt kode;
Knap LogInd, reset;
Knap WipeYes, WipeNo;
Forside forside;
RandomString test2;
String testString;
int hr = 128, hg = 183, hb = 245;
int cr = 3, cg = 102, cb = 214;
Boolean TrykReset = false;
RandomString test3 = new RandomString();
AES test = new AES();
String password;
JSONArray db = new JSONArray();
JSONObject pw = new JSONObject();
RandomString saltGen = new RandomString();
String salt;
AES aes;
Hash512 hash = new Hash512();
Hash256 hash256 = new Hash256();
boolean passwordMatch = false;
String hashedTemp;

void setup(){
    size(800,800);

    salt = saltGen.genRandString(20);
    
    kode = new TekstFelt(this,300,350,300,50,"Kodeord");
    LogInd = new Knap(this, width/2, 420,300,50,"Log Ind","getPassword",hr,hg,hb,cr,cg,cb);
    reset = new Knap(this, 720, 30,100,50,"Fjern alt data","ResetData",235,3,3,0,0,0);
    WipeYes = new Knap(this, width/2+100, height/2+100,100,50,"Ja","WipeDatabase",235,3,3,cr,cg,cb);
    WipeNo = new Knap(this, width/2-100, height/2+100,100,50,"Nej","KeepData",7, 250, 2,cr,cg,cb);


    forside = new Forside(this, LogInd, reset, kode,WipeYes,WipeNo);

    String temp3 = "oog" + salt;

    hashedTemp = hash.encryptThisString(temp3);

    println(hashedTemp);

    String hashedSalt = hash.encryptThisString(salt);

    println(hashedSalt);

    aes = new AES();

    String encryptedTemp = aes.encrypt(hashedTemp,hashedTemp,salt);

    println(encryptedTemp);

    pw.setString("password",encryptedTemp);

    db.setJSONObject(0,pw);
}

void draw(){
    background(#24292e);
    forside.runDisplay();
    textSize(25);

    if(TrykReset == true){
        forside.DataWipe();

    }

}

void keyPressed(){
    forside.runKeys();
}

void mousePressed(){
    forside.runMouse();

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
    String decryptyPassword = aes.encrypt(hashyPassword,hashyPassword,salt);
    println(decryptyPassword);

    passwordMatch = temp.equals(decryptyPassword);
    println(passwordMatch);
}

void ResetData(){
    println("test reset");
    TrykReset = true;
    println(TrykReset);

}

void WipeDatabase(){

}

void KeepData(){
    TrykReset = false;
}