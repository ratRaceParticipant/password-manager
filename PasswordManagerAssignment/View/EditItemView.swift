//
//  EditItemView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI

struct EditItemView: View {
    @StateObject var vm: EditItemViewModel
    @Binding var showEditableView: Bool
    @EnvironmentObject var dataHandler: DataHandler
    @Environment(\.dismiss) var dismiss
    @State var showValidationAlert: Bool = false
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showEditableView = false
                }, label: {
                    HStack{
                        Image(systemName: "chevron.left")
                             .font(.headline)
                        Text("Back")
                    }
                })
                Spacer()
            }
            .padding()
            GeneralViews.getTextField(bindingText: $vm.accountType, placeholderText: "Account Type")
            
            GeneralViews.getTextField(bindingText: $vm.userName, placeholderText: "Username/ Email")
            
            GeneralViews.getSecureField(bindingText: $vm.decryptedMessage, placeholderText: "Password")
            
            updateButton
        }
        .alert("Error", isPresented: $showValidationAlert) {
            Button("Ok", role: .cancel) {
                showValidationAlert = false
            }
        } message: {
            Text(vm.validationError.getValidationError())
        }
        .onAppear{
            vm.decryptMessage()
        }
    }
   
    var updateButton: some View {
        Button(action: {
            vm.validateData()
            if(vm.isDataInvalid){
                showValidationAlert = true
            } else {
                updateData()
                dismiss.callAsFunction()
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
    func updateData(){
        let passwordData = vm.updateData()
        self.dataHandler.updatePassword(passwordManagerModelData:passwordData)
    }
}

#Preview {
    EditItemView(vm: EditItemViewModel(passwordManagerDataModel: PasswordManagerDataModel()), showEditableView: .constant(false))
}
