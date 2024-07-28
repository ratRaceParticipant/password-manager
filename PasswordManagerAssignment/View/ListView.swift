//
//  ListView.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import SwiftUI

struct ListView: View {

    @State var selectedData: PasswordManagerDataModel?
    
    @State var showSummarySheet: Bool = false
    @EnvironmentObject var dataHandler: DataHandler
    var body: some View {
        
        ScrollView {
            ForEach(dataHandler.passwordManagerData){ data in
                Button(action: {
                    showSummarySheet = true
                    selectedData = data
                }, label: {
                    ListItemView(passwordData: data)
                        .tint(.primary)
                })
            }
        }
        .sheet(item: $selectedData, content: { data in
            AccountSummaryViewWrapper(passwordManagerData: data)
                .environmentObject(dataHandler)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.hidden)
        })
        
    }
}

#Preview {
    ListView()
}
