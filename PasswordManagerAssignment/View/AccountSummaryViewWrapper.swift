//
//  AccountSummaryViewWrapper.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI

struct AccountSummaryViewWrapper: View {
    var passwordManagerData: PasswordManagerDataModel
    @State var showEditableView: Bool = false
    var body: some View {
        if(showEditableView){
            EditItemView(vm: EditItemViewModel(passwordManagerDataModel: passwordManagerData), showEditableView: $showEditableView)
        } else {
            AccountSummaryView(passwordManagerData: passwordManagerData, showEditableView: $showEditableView)
        }
    }
}

#Preview {
    AccountSummaryViewWrapper(passwordManagerData: PasswordManagerDataModel())
}
