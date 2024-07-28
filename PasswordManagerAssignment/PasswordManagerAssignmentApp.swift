//
//  PasswordManagerAssignmentApp.swift
//  PasswordManagerAssignment
//
//  Created by Himanshu Karamchandani on 27/07/24.
//

import SwiftUI

@main
struct PasswordManagerAssignmentApp: App {
    @StateObject private var dataHandler = DataHandler()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
               ContentView()
            }
            .environmentObject(dataHandler)
            .environment(\.managedObjectContext, dataHandler.container.viewContext)
        }
        
    }
}
