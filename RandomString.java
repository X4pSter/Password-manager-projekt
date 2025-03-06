import java.security.SecureRandom;

public class RandomString {

    private byte randomBytes[];

    private int randomNumbers[];

    private AllCharacters allCharacters = new AllCharacters();

    private String allCharactersArray[] = AllCharacters.genArray();

    SecureRandom secureRandom = new SecureRandom();

    public String genRandString(int l){
        String randString = "";

        randomBytes = new byte[l];

        randomNumbers = new int[l];

        secureRandom.nextBytes(randomBytes);

        for(int i = 0; i < randomNumbers.length; i++){
            randomNumbers[i] = Math.abs(randomBytes[i]);
        }

        for(int i = 0; i < l; i++){
            int temp = randomNumbers[i];
            randString += allCharactersArray[temp%allCharactersArray.length];
        }

        return(randString);
    }

}

