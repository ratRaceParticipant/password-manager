//
//  EditItemViewModel.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation

class EditItemViewModel: ObservableObject {
    
    @Published var decryptedMessage: String = ""
    @Published var userName: String
    @Published var accountType: String
    @Published var passwordManagerModelData: PasswordManagerDataModel
    @Published var isDataInvalid: Bool = false
    @Published var validationError: ValidationError = .noError
    
    
    init(passwordManagerDataModel: PasswordManagerDataModel){
        self.userName = passwordManagerDataModel.userName ?? ""
        self.accountType = passwordManagerDataModel.accountType ?? ""
        self.decryptedMessage = passwordManagerDataModel.password ?? ""
        
        self.passwordManagerModelData = passwordManagerDataModel
    }
    func updateData() -> PasswordManagerDataModel{

        do {
            let encryptedMessage = try CryptoKitHelper.shared.encrypt(message: self.decryptedMessage, key: Constants.CRYPTO_KEY)
            
            guard let encryptedMessage = encryptedMessage else {
                throw PMError.runtimeError("Error in unwrapping encrypted password")
            }
            passwordManagerModelData.accountType = accountType
            
            passwordManagerModelData.userName = userName
            passwordManagerModelData.password = encryptedMessage
            print("Encrypted Message: \(encryptedMessage)")
            
        } catch {
            print("Error in Encrypting password: \(error)")
        }
        return passwordManagerModelData
    }
    
    
    func decryptMessage(){
        do {
            let decryptedPassword = try CryptoKitHelper.shared.decrypt(encodedMessage:self.decryptedMessage, key: Constants.CRYPTO_KEY)
            
            guard let decryptedPassword = decryptedPassword else {
                throw PMError.runtimeError("Error in unwrapping password")
            }
            
            self.decryptedMessage = decryptedPassword
            
            print("Decrypted password: \(decryptedPassword)")
        } catch {
            print("Error in decrypting password: \(error)")
        }
        
    }
    
    func validateData(){
        let maxLength = Constants.MAX_TEXT_LENGTH
        if(
            accountType.isEmpty ||
            userName.isEmpty ||
            decryptedMessage.isEmpty
        ){
            self.isDataInvalid = true
            self.validationError = .mandatory
           
        } else {
            if(
                accountType.count>maxLength ||
                userName.count>maxLength ||
                decryptedMessage.count>maxLength
            ){
                self.isDataInvalid = true
                self.validationError = .characterLessThan30
            } else {
                self.isDataInvalid = false
            }
            
        }
    }
}
