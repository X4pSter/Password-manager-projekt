import java.util.ArrayList;
import java.util.List;

public class AllCharacters {
    public static String[] genArray() {
        List<String> characters = new ArrayList<>();
        
        // Add lowercase letters
        for (char c = 'a'; c <= 'z'; c++) {
            characters.add(String.valueOf(c));
        }
        
        // Add uppercase letters
        for (char c = 'A'; c <= 'Z'; c++) {
            characters.add(String.valueOf(c));
        }
        
        // Add digits
        for (char c = '0'; c <= '9'; c++) {
            characters.add(String.valueOf(c));
        }
        
        // Add commonly allowed special characters
        String specialChars = "!@#$%^&*()-_+=";
        for (char c : specialChars.toCharArray()) {
            characters.add(String.valueOf(c));
        }
        
        // Convert List to array
        String[] characterArray = characters.toArray(new String[0]);

        return(characterArray);
    }
}
