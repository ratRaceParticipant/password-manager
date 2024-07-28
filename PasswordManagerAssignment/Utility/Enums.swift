//
//  Enums.swift
//  PasswordManager
//
//  Created by Himanshu Karamchandani on 26/07/24.
//

import Foundation

enum PMError: Error {
    case runtimeError(String)
}
enum ValidationError: String {
    case mandatory
    case characterLessThan30
    case noError
    func getValidationError() -> String{
        switch self {
        case .mandatory:
            return "All the fields are mandatory"
        case .characterLessThan30:
            return "Field values should be less than 30 letters"
            
        case .noError:
            return ""
        
        }
    }
}
