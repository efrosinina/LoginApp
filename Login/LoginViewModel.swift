//
//  LoginViewModel.swift
//  Login
//
//  Created by Елизавета Ефросинина on 09/06/2023.
//

import Foundation

class LoginViewModel {
    //MARK: -- Methods
    func checkEmail(email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    func checkPassword(password: String) -> Bool {
        let passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPredicate.evaluate(with: password)
    }
}
