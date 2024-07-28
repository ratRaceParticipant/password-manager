//
//  AccountSummaryView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI
import UniformTypeIdentifiers


struct AccountSummaryView: View {
    var passwordManagerData: PasswordManagerDataModel
    @StateObject var vm = AccountSummaryViewModel()
    @Binding var showEditableView: Bool
    @EnvironmentObject var dataHandler: DataHandler
    @Environment(\.presentationMode) var presentationMode
    @State var showPassword: Bool = false
    @State var copiedToClipBoard: Bool = false
    var body: some View {
        VStack {
            HStack {
                passwordDetails
                Spacer()
            }
            summaryViewActions
        }
        .padding()
        .overlay(content: {
            if copiedToClipBoard {
                copyToClipboardConfirmation
            }
        })
        .onAppear{
            vm.decryptPassword(password: passwordManagerData.password ?? "")
        }
    }
    var passwordDetails: some View {
        VStack(alignment: .leading) {
            Text("Account Details")
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
                .padding(.bottom)
            GeneralViews.displayText(text: passwordManagerData.accountType ?? "", labelText: "Account Type")
                .padding(.bottom)
            
            GeneralViews.displayText(text: passwordManagerData.userName ?? "", labelText: "Username/ Email")
                .padding(.bottom)
            
            HStack {
                GeneralViews.displayText(text: showPassword ? vm.decryptedPassword : Constants.DUMMY_HIDDEN_PASSWORD, labelText: "Password")
                    
                Spacer()
                
                summaryViewPasswordActions
            }
        }
            .padding(.bottom)
    }
    var copyToClipboardConfirmation: some View {
        Text("Copied To Clipboard")
            .foregroundStyle(.white)
            .padding()
            .background (Color.green.cornerRadius (20))
            .padding(.bottom)
            .shadow (radius: 5)
            .transition(.move(edge: .top))
            .frame(maxHeight: .infinity, alignment: .top)
    }
    var summaryViewPasswordActions: some View {
        HStack {
            Button(action: {
                UIPasteboard.general.string = vm.decryptedPassword
                withAnimation(.snappy) {
                    copiedToClipBoard = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    withAnimation(.snappy) {
                        copiedToClipBoard = false
                    }
                }
            }, label: {
                Image(systemName: "clipboard.fill")
                    .font(.system(size: 30))
            })
            
            Button(action: {
                showPassword.toggle()
                
            }, label: {
                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .font(.system(size: 30))
            })
            .padding(.leading)
        }
    }
    var summaryViewActions: some View {
        HStack(alignment: .center) {
            Button(action: {
                showEditableView = true
            }, label: {
                Text("Edit")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 180)
                    .background(
                        Color.black
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
            })
            
            Button(action: {
                dataHandler.deletePassword(passwordData: passwordManagerData)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Delete")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 180)
                    .background(
                        Color.red
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            })
        }
    }
}

#Preview {
    AccountSummaryView(passwordManagerData: PasswordManagerDataModel(),showEditableView: .constant(false))
}
