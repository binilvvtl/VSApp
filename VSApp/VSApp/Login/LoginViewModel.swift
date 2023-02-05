//
//  LoginViewModel.swift
//  VSApp
//
//  Created by Binil-V on 05/02/23.
//

import Foundation

class LoginViewModel {
    var email: String? = ""
    var password: String? = ""
    
    var emailValidation: String? {
        
        if !(email ?? "").isValidEmail() {
            return "invalidEmail".localized()
        }
        return nil
    }
    
    var passwordValidation: String? {
        if !(password ?? "").isValidPassword() {
            return "invalidPassword".localized()
        }
        return nil
    }
    
    var isValid: Bool {
        return emailValidation == nil && passwordValidation == nil
    }
}
