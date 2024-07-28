//
//  PasswordManagerModel.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation
import CoreData
struct PasswordManagerModel: Identifiable {
    
    internal init(accountType: String, userName: String, password: String) {
        self.accountType = accountType
        self.userName = userName
        self.password = password
    }
    
    let id: String = UUID().uuidString
    var accountType: String
    var userName: String
    var password: String
    
    init(){
        accountType = ""
        userName = ""
        password = ""
    }
    
//    init(passwordManagerData: PasswordManagerModel){
//        self.accountType = passwordManagerData.accountType
//        self.userName = passwordManagerData.userName
//        self.password = passwordManagerData.password
//    }
    
    static let emptyData = PasswordManagerModel()
}
extension PasswordManagerModel {
//    static let sampleData: [PasswordManagerModel] = [
//        PasswordManagerModel(accountType: "facebook", userName: "himanshu@1", password: "pass"),
//        PasswordManagerModel(accountType: "instagram", userName: "himanshu@2", password: "pass1"),
//        PasswordManagerModel(accountType: "github", userName: "himanshu@2", password: "pass1")
//    ]
    static func getDataModel(passwordManagerModel: PasswordManagerModel, container: NSPersistentContainer) -> PasswordManagerDataModel {
        let passwordToAdd = PasswordManagerDataModel(context: container.viewContext)
        passwordToAdd.accountType = passwordManagerModel.accountType
        passwordToAdd.userName = passwordManagerModel.userName
        passwordToAdd.password = passwordManagerModel.password
        passwordToAdd.id = UUID()
        return passwordToAdd
    }
    
//    static func convertDataModelToModel(passwordManagerDataModel: PasswordManagerDataModel)-> PasswordManagerModel{
//        return PasswordManagerModel(accountType: passwordManagerDataModel.accountType ?? "", userName: passwordManagerDataModel.userName ?? "", password: passwordManagerDataModel.password ?? "")
//    }
}
