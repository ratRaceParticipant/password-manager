//
//  CryptoKitHelper.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation
import CryptoKit

class CryptoKitHelper {
    
    static let shared = CryptoKitHelper()
    
    private init (){}
    
//    private var sealedBox: AES.GCM.SealedBox?
    
    func encrypt(message: String, key: String) throws -> String? {
        
        let iv = AES.GCM.Nonce()
        
        
        guard let messageData = message.data(using: .utf8),
              let keyData = key.data(using: .utf8)
        else {
            return nil
        }
        let key: SymmetricKey = SymmetricKey(data: keyData)
        
        do {
            let sealedBox = try AES.GCM.seal(messageData, using: key, nonce: iv)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            throw error
        }
    }
    
    func decrypt(encodedMessage: String, key: String) throws -> String? {
        
        guard let encodedMessageData = Data(base64Encoded: encodedMessage),
            let keyData = key.data(using: .utf8) else {
            return nil
        }
        
        let symmetricKey = SymmetricKey(data: keyData)
        
        do{
            let sealedBoxToOpen = try AES.GCM.SealedBox(combined: encodedMessageData)
            let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: symmetricKey)
            return String(decoding: decryptedData, as: UTF8.self)
        } catch {
            throw error
        }
    }
}
