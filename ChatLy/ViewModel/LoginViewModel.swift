//
//  LoginViewModel.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    
    var status: Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
    
}
