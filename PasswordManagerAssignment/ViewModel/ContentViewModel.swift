//
//  ContentViewModel.swift
//  PasswordManagerAssignment
//
//  Created by Himanshu Karamchandani on 28/07/24.
//

import Foundation
import LocalAuthentication

class ContentViewModel: ObservableObject {
    @Published var isUnlocked: Bool = false
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Authentication required to unlock passwords"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    // authentication complete
                    DispatchQueue.main.async {
                        self.isUnlocked = true
                    }
                } else {
                    // problem in authentication
                    DispatchQueue.main.async {
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            isUnlocked = true
            // no biometrics available
        }
    }
}
