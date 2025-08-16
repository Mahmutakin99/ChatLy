//
//  User.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 05/08/2025.
//

struct User {
    let email: String
    let name: String
    let userName: String
    let uid: String
    let profilePhotoUrl: String
    init(data: [String: Any]) {
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.userName = data["userName"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.profilePhotoUrl = data["profilePhotoUrl"] as? String ?? ""
    }
}

struct LastUser {
    let user: User
    let message: Message
}
