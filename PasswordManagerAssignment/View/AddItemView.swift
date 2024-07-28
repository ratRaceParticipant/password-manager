//
//  AddItemView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var dataHandler: DataHandler
    @StateObject var vm = AddItemViewModel()
    @State var showValidationAlert: Bool = false
    @Binding var showAddItemSheet: Bool
    var body: some View {
        formView
        .alert("Error", isPresented: $showValidationAlert) {
            Button("Ok", role: .cancel) {
                showValidationAlert = false
            }
        } message: {
            Text(vm.validationError.getValidationError())
        }

    }
    var formView: some View {
        VStack {
            GeneralViews.getTextField(bindingText: $vm.passwordManagerData.accountType, placeholderText: "Account Type")
                .padding(.top)
            
            GeneralViews.getTextField(bindingText: $vm.passwordManagerData.userName, placeholderText: "Username/ Email")
            
            GeneralViews.getSecureField(bindingText: $vm.passwordManagerData.password, placeholderText: "Password")
            Spacer()
            addNewItemButton
        }
    }
    var addNewItemButton: some View {
        Button(action: {
            vm.validateData()
            if(vm.isDataInvalid){
                showValidationAlert = true
            } else {
                addNewItem()
                showAddItemSheet = false
            }
        }, label: {
            Text("Save")
                .fontWeight(.bold)
                .tint(Color("plain"))
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(
                    Color.primary
                )
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                .padding()
        })
    }
    
    func addNewItem(){
        vm.addNewItem()
        dataHandler.addPassword(passwordManagerModel: vm.passwordManagerData)
    }
}

#Preview {
    AddItemView(showAddItemSheet: .constant(false))
}
