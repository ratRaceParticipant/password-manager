//
//  ListItemView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI
import CoreData
struct ListItemView: View {
    var passwordData: PasswordManagerDataModel
    var body: some View {
        HStack(alignment: .center) {
            Text(passwordData.accountType ?? "Account Type")
                .lineLimit(1)
                .truncationMode(.tail)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.trailing)
            Text(Constants.DUMMY_HIDDEN_PASSWORD)
                .font(.caption)
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(Color("plain"))
                .shadow(color: .secondary.opacity(0.5), radius: 5,y: 5)
        )
        
        .padding([.horizontal,.bottom])
    }
}

//#Preview {
//    
//    ListItemView()
//}
