//
//  DataHandler.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 27/07/24.
//

import Foundation
import CoreData


class DataHandler: ObservableObject{
    let container = NSPersistentContainer(name: "PasswordManagerDataModel")
    @Published var passwordManagerData: [PasswordManagerDataModel] = []
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error in loading core data: \(error.localizedDescription)")
            }
            
        }
        fetchPasswordData()
        
    }
    
    func fetchPasswordData(){
        let request = NSFetchRequest<PasswordManagerDataModel>(entityName: "PasswordManagerDataModel")
        let sort = NSSortDescriptor(keyPath: \PasswordManagerDataModel.accountType, ascending: true)
        
        request.sortDescriptors = [sort]
        do {
            passwordManagerData = try container.viewContext.fetch(request)
            
            
            
            print("Fetch data called")
            
        } catch let error {
            print("Error Fetching Transaction Data: \(error)")
        }
        
    }
    
    func addPassword(passwordManagerModel: PasswordManagerModel) {
        
        _ = PasswordManagerModel.getDataModel(passwordManagerModel: passwordManagerModel, container: container)
        
        saveData()
    }
    
    func deletePassword(passwordData: PasswordManagerDataModel) {
        
        container.viewContext.delete(passwordData)
        saveData()
    }
    
    func updatePassword(passwordManagerModelData: PasswordManagerDataModel){
        passwordManagerModelData.id = UUID()
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchPasswordData()
        } catch let error {
            print("Error Saving Data: \(error)")
        }
    }
}
