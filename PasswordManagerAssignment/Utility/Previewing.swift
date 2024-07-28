//
//  Previewing.swift
//  PasswordManagerAssignment
//
//  Created by Himanshu Karamchandani on 28/07/24.
//

import SwiftUI
import CoreData

struct Previewing<Content: View, Model>: View {
    var content: Content
    var persistence: DataHandler
    var body: some View {
        content
            .environment(\.managedObjectContext,persistence.container.viewContext)
    }
}
