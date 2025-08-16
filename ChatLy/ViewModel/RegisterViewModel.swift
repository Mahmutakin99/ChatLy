//
//  RegisterViewModel.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 31/07/2025.
//

struct RegisterViewModel{
    var email: String?
    var name: String?
    var userName: String?
    var password: String?
    
    var isUsernameAvailable: Bool = false
    
    var status: Bool{
        return email?.isEmpty == false && name?.isEmpty == false && userName?.isEmpty == false && password?.isEmpty == false && isUsernameAvailable
    }
}
