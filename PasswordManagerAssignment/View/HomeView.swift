//
//  HomeView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI

struct HomeView: View {
    @State var showAddItemSheet: Bool = false
    @EnvironmentObject var dataHandler: DataHandler
    var body: some View {
        Group {
            if(dataHandler.passwordManagerData.isEmpty){
                VStack {
                    Text("No Passwords Available")
                    Button("Add Passwords", action: {
                        showAddItemSheet = true
                    })
                        .buttonStyle(BorderedProminentButtonStyle())
                }
            } else {
                ZStack(alignment: .bottomTrailing) {
                    ListView()
                        
                    floatingAddButton
                }
                
            }
        }
        .navigationTitle("Password Manager")
        .sheet(isPresented: $showAddItemSheet, content: {
            AddItemView(showAddItemSheet: $showAddItemSheet)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.hidden)
                .environmentObject(dataHandler)
        })
        
            
    }
    var floatingAddButton: some View {
        Button {
            showAddItemSheet = true
        } label: {
            Image(systemName: "plus")
                .tint(.white)
                .padding()
                .background(
                    Color.accentColor
                )
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
        .padding()
       
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
