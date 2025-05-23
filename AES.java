// Java program to demonstrate the creation 
// of Encryption and Decryption with Java AES 
import java.nio.charset.StandardCharsets;
import java.security.spec.KeySpec;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec; 
import javax.crypto.spec.SecretKeySpec; 
  
public class AES{ 
    
    // This method use to encrypt to string 
    public String encrypt(String strToEncrypt, String sk, String s) { 

        try { 

            String SECRET_KEY = sk;
            String SALT = s;
  
            // Create default byte array 
            byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; 
            IvParameterSpec ivspec = new IvParameterSpec(iv); 
  
            // Create SecretKeyFactory object 
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256"); 
            
            // Create KeySpec object and assign with 
            // constructor 
            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALT.getBytes(), 65536, 256); 
                
            SecretKey tmp = factory.generateSecret(spec); 
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES"); 
  
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding"); 
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec); 

            // Return encrypted string 
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8))); 
        } 
        catch (Exception e) { 
            System.out.println("Error while encrypting: "+ e.toString()); 
        } 
        return null; 
    } 
  
    // This method use to decrypt to string 
    public String decrypt(String strToDecrypt, String sk, String s) { 

        try { 
            
            String SECRET_KEY = sk;
            String SALT = s;

            // Default byte array 
            byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; 

            // Create IvParameterSpec object and assign with 
            // constructor 
            IvParameterSpec ivspec 
                = new IvParameterSpec(iv); 
  
            // Create SecretKeyFactory Object 
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256"); 
  
            // Create KeySpec object and assign with 
            // constructor 

            byte[] temp = SALT.getBytes();

            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), temp, 65536, 256); 

            SecretKey tmp = factory.generateSecret(spec); 
            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES"); 
  
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING"); 
            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivspec); 

            // Return decrypted string 
            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt))); 
        } 
        catch (Exception e) { 
            System.out.println("Error while decrypting: "+ e.toString()); 
        } 
        return null; 
    } 
} 