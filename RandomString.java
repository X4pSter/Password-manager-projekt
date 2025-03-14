import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

public class RandomString {

    private byte randomBytes[];

    private int randomNumbers[];

    SecureRandom secureRandom = new SecureRandom();

    private void genSeed(int l){
        randomBytes = new byte[l];

        secureRandom.nextBytes(randomBytes);

        for(int i = 0; i < randomBytes.length; i++){
            randomBytes[i] = (byte)Math.abs(randomBytes[i]);
        }
    }

    public String genRandString(int l){
        String randString = "";

        if(randomBytes == null){
            genSeed(l);
        }

        randString = new String(randomBytes,StandardCharsets.UTF_8);
        return(randString);
    }

}

