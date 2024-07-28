//
//  AddItemViewModel.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation
import SwiftUI
class AddItemViewModel: ObservableObject {
    @EnvironmentObject var dataHandler: DataHandler
    @Published var passwordManagerData = PasswordManagerModel.emptyData
    @Published var isDataInvalid: Bool = false
    @Published var validationError: ValidationError = .noError
    func addNewItem(){
        do {
            let encryptedMessage = try CryptoKitHelper.shared.encrypt(message: self.passwordManagerData.password, key: Constants.CRYPTO_KEY)
            guard let encryptedMessage = encryptedMessage else {
                throw PMError.runtimeError("Error in unwrapping encrypted password")
            }
            
            passwordManagerData.password = encryptedMessage
            
            print("Encrypted Message: \(encryptedMessage)")
            
            
            
            
        } catch {
            print("Error in Encrypting password: \(error)")
        }
    }
    
    func validateData(){
        let maxLength = Constants.MAX_TEXT_LENGTH
        if(
            passwordManagerData.accountType.isEmpty ||
            passwordManagerData.userName.isEmpty ||
            passwordManagerData.password.isEmpty
        ){
            self.isDataInvalid = true
            self.validationError = .mandatory
           
        } else {
            if(
                passwordManagerData.accountType.count>maxLength ||
                passwordManagerData.userName.count>maxLength ||
                passwordManagerData.password.count>maxLength
            ){
                self.isDataInvalid = true
                self.validationError = .characterLessThan30
            } else {
                self.isDataInvalid = false
            }
            
        }
    }
}
