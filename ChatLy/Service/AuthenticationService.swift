//
//  AuthenticationService.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 04/08/2025.
//
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct AuthenticationServiceUser{
    var emailText: String
    var passwordText: String
    var nameText: String
    var userNameText: String
}

struct AuthenticationService{
    
    static func login(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func isUsernameAvailable(_ username: String, completion: @escaping (Bool) -> Void) {
        let query = Firestore.firestore().collection("users").whereField("userName", isEqualTo: username)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to check username availability \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(true)
                return
            }
            completion(documents.isEmpty)
        }
    }

    
    static func register(withUser user: AuthenticationServiceUser, image: UIImage, completion: @escaping(Error?)->Void){
        let photoName = UUID().uuidString
        guard let profileData = image.jpegData(compressionQuality: 0.5) else { return }
        let referance = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
        referance.putData(profileData) { storegeMeta, error in
            if let error = error{
                completion(error)
                return
            }
            referance.downloadURL { url, error in
                if let error = error{
                    completion(error)
                    return
                }
                guard let profilePhotoUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    guard let userUid = result?.user.uid else { return }
                    let data = [
                        "email": user.emailText,
                        "name": user.nameText,
                        "userName": user.userNameText,
                        "profilePhotoUrl": profilePhotoUrl,
                        "uid": userUid,
                        
                    ] as [String: Any]
                    Firestore.firestore().collection("users").document(userUid).setData(data, completion: completion)
                }
            }
        }
    }
}
