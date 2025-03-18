public class CryptoUtil {
    private static final String SECRET_KEY = 'AnyStringActingAsKey'; // taking key for the encryption and decryption

    public static String encrypt(String plainText) {
        Blob key = getKey();
        Blob encryptedBlob = Crypto.encryptWithManagedIV('AES128',key, Blob.valueOf(plainText));
        return EncodingUtil.base64Encode(encryptedBlob);
    }

    public static String decrypt(String encryptedText) {
        Blob encryptedBlob = EncodingUtil.base64Decode(encryptedText);
        Blob key = getKey();
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', key, encryptedBlob);
        return decryptedBlob.toString();
    }

  
    private static Blob getKey() {
        // 1.Generating SHA-256 hash of the secret key (32 bytes),generateDigest creates hash
        Blob hash = Crypto.generateDigest('SHA-256', Blob.valueOf(SECRET_KEY));
        
        // 2.Now converted hash to hex string to extract first 32 chars (16 bytes)
        String hexHash = EncodingUtil.convertToHex(hash);
        String truncatedHex = hexHash.substring(0, 32); // 32 hex chars = 16 bytes
        
        // 3.Converting back to Blob
        return EncodingUtil.convertFromHex(truncatedHex);
    }
}