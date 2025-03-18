# CryptoUtil

Welcome to the CryptoUtil project! This Apex utility class is designed to help you securely encrypt and decrypt text using AES-128 encryption.

## What is CryptoUtil?

CryptoUtil provides a simple way to protect sensitive information by converting plain text into a secure format. It uses a secret key that is hashed for added security, ensuring that your data remains safe in Salesforce.

## Key Features

- **Encrypt**: Convert your plain text into a secure, base64 encoded string.
- **Decrypt**: Turn the encoded string back into its original plain text form.
- **Secure Key Management**: The secret key is hashed using SHA-256 for enhanced security.

## How to Use

Using CryptoUtil is straightforward! Here’s how you can encrypt and decrypt your text in Apex:

1. **Encrypting Text**:
   ```apex
   String plainText = 'YourSensitiveData';
   String encryptedText = CryptoUtil.encrypt(plainText);
   System.debug('Encrypted: ' + encryptedText);
   ```

2. **Decrypting Text**:
   ```apex
   String decryptedText = CryptoUtil.decrypt(encryptedText);
   System.debug('Decrypted: ' + decryptedText);
   ```

## Complete Code for CryptoUtil

Here is the complete code for the `CryptoUtil` class:

```apex
public class CryptoUtil {
    private static final String SECRET_KEY = 'AnyStringActingAsKey'; // taking key for the encryption and decryption

    public static String encrypt(String plainText) {
        Blob key = getKey();
        Blob encryptedBlob = Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(plainText));
        return EncodingUtil.base64Encode(encryptedBlob);
    }

    public static String decrypt(String encryptedText) {
        Blob encryptedBlob = EncodingUtil.base64Decode(encryptedText);
        Blob key = getKey();
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', key, encryptedBlob);
        return decryptedBlob.toString();
    }

    private static Blob getKey() {
        // 1. Generating SHA-256 hash of the secret key (32 bytes), generateDigest creates hash
        Blob hash = Crypto.generateDigest('SHA-256', Blob.valueOf(SECRET_KEY));
        
        // 2. Now converted hash to hex string to extract first 32 chars (16 bytes)
        String hexHash = EncodingUtil.convertToHex(hash);
        String truncatedHex = hexHash.substring(0, 32); // 32 hex chars = 16 bytes
        
        // 3. Converting back to Blob
        return EncodingUtil.convertFromHex(truncatedHex);
    }
}
```

## Getting Started

To get started with CryptoUtil, simply include the class in your Salesforce org and call the `encrypt` and `decrypt` methods as shown above.

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute it as you wish!

## Questions or Feedback?

If you have any questions or feedback, feel free to reach out. Happy coding!
