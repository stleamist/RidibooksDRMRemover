import Foundation
import Commander

command(
    Argument<String>("epub_path", description: "path of ePub file to remove DRM"),
    Argument<String>("secret_key", description: "key to decrypt ePub file with AES"),
    Flag("apple-books", default: false, flag: "a", description: "use specified fonts for Apple Books")
) { ePubPath, secretKey, usesSpecifiedFonts in
    let encryptedEPubURL = URL(fileURLWithPath: ePubPath)
    
    let decryptedEPubName = encryptedEPubURL.deletingPathExtension().lastPathComponent.appending("-noDRM")
    let decryptedEPubExtension = encryptedEPubURL.pathExtension
    let decryptedEPubURL = encryptedEPubURL.deletingLastPathComponent().appendingPathComponent(decryptedEPubName).appendingPathExtension(decryptedEPubExtension)
    
    decryptEPub(from: encryptedEPubURL, to: decryptedEPubURL, secretKey: secretKey)
    
    if usesSpecifiedFonts {
        addAppleBooksDisplayOptions(to: decryptedEPubURL)
    }
}.run()
