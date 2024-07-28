//
//  AccountSummaryViewModel.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation
class AccountSummaryViewModel: ObservableObject {
    @Published var decryptedPassword: String = Constants.DUMMY_HIDDEN_PASSWORD
    
    func decryptPassword(password: String){
        do {
            let decryptedPassword = try CryptoKitHelper.shared.decrypt(encodedMessage: password, key: Constants.CRYPTO_KEY)
            
            guard let decryptedPassword = decryptedPassword else {
                throw PMError.runtimeError("Error in unwrapping password")
            }
            
            self.decryptedPassword = decryptedPassword
            
            print("Decrypted password: \(decryptedPassword)")
        } catch {
            print("Error in decrypting password: \(error)")
        }
        
    }
}
