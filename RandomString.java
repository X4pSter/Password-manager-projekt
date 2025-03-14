import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

public class RandomString {

    private byte randomBytes[];

    private int randomNumbers[];

    private AllCharacters allCharacters = new AllCharacters();

    private String allCharactersArray[] = AllCharacters.genArray();

    SecureRandom secureRandom = new SecureRandom();

    private void genSeed(int l){
        randomBytes = new byte[l];

        secureRandom.nextBytes(randomBytes);

        for(int i = 0; i < randomBytes.length; i++){
            randomBytes[i] = (byte)Math.abs(randomBytes[i]);
        }
    }

    public String genRandString(int l){
        /*
        String randString = "";

        randomNumbers = new int[l];

        if(randomBytes == null){
            genSeed(l);
        }

        for(int i = 0; i < randomNumbers.length; i++){
            randomNumbers[i] = Math.abs(randomBytes[i]);
        }

        for(int i = 0; i < l; i++){
            int temp = randomNumbers[i];
            randString += allCharactersArray[temp%allCharactersArray.length];
        }

        return(randString);
        */
        String randString = "";

        if(randomBytes == null){
            genSeed(l);
        }

        randString = new String(randomBytes,StandardCharsets.UTF_8);
        return(randString);
    }

}

