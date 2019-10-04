import Foundation
import CryptoSwift
import ZIPFoundation

func decryptEPub(from encryptedEPubURL: URL, to decryptedEPubURL: URL, secretKey: String) {
    let aes128ECB = try! AES(key: secretKey.bytes, blockMode: ECB())

    let encryptedEPubData = try! Data(contentsOf: encryptedEPubURL)
    let decryptedEPubData = try! encryptedEPubData.decrypt(cipher: aes128ECB)

    try! decryptedEPubData.write(to: decryptedEPubURL)
}

func addAppleBooksDisplayOptions(to ePubURL: URL) {
    let decryptedEPubArchive = Archive(url: ePubURL, accessMode: .update)!
    
    try! decryptedEPubArchive.addEntry(with: AppleBooksDisplayOptions.entryPath, type: .file, uncompressedSize: UInt32(AppleBooksDisplayOptions.xmlData.count), provider: { (position, size) -> Data in
        return AppleBooksDisplayOptions.xmlData.subdata(in: position..<(position + size))
    })
}
