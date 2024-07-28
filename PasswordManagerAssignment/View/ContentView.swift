//
//  ContentView.swift
//  PasswordManagerAssignment
//
//  Created by Himanshu Karamchandani on 27/07/24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
//    @State private var isUnlocked: Bool = false
    var body: some View {
        
        VStack {
            if vm.isUnlocked {
                HomeView()
            } else {
                VStack {
                    Text("Authentication Failed")
                    Button(action: {
                        vm.isUnlocked = true
                    }, label: {
                        Text("Click here in case face id functionality is not working.")
                    })
                    Text("I tested Face ID on a simulator, hence providing a backdoor in case it works diffrently on a real device.")
                }
            }
        }
        .onAppear{
            vm.authenticate()
        }
    }
   
}

#Preview {
    ContentView()
}
