//
//  Utils.swift
//  ToDo
//
//  Created by Le Hen Hugo on 05/04/2024.
//

import Foundation
import CryptoKit

extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
    func hexEncodedString() -> String {
           map { String(format: "%02hhx", $0) }.joined()
       }
}


let key = SymmetricKey(size: .bits256)

func encrypt(content: String) -> String? {
    guard let contentData = content.data(using: .utf8) else {
        return nil
    }
    
    guard let key = retrieveKey() else {
        return nil
    }
    
    do {
        let sealedBox = try AES.GCM.seal(contentData, using: key)
        return sealedBox.combined?.hexEncodedString()
    } catch {
         return nil
    }
}


func decrypt(content: String) -> String? {
    guard let data = Data(hexString: content) else {
        return nil
    }
    
    guard let key = retrieveKey() else {
        return nil
    }
    
    do {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return String(data: decryptedData, encoding: .utf8)
    } catch {
        print("Erreur on decrypt: \(error)")
        return nil
    }
}



func generateAndStoreKey() {
    let key = SymmetricKey(size: .bits256)
    let keyData = key.withUnsafeBytes {
        return Data(Array($0))
    }
    UserDefaults.standard.set(keyData, forKey: "encryptionKey")
}


func retrieveKey() -> SymmetricKey? {
    guard let keyData = UserDefaults.standard.data(forKey: "encryptionKey") else { return nil }
    return SymmetricKey(data: keyData)
}
