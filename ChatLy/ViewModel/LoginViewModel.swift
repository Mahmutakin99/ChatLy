//
//  LoginViewModel.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    
    //emailTextField ve passwordTextField bölümünün dolu olup olmadığını bool olarak döndürür
    var status: Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
    
}
