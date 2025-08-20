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
            if error != nil {
                //print("DEBUG: Failed to check username availability \(error.localizedDescription)")
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
    
    static func updateUserProfile(name: String, userName: String, profileImage: UIImage?, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"]))
            return
        }
        
        var updateData: [String: Any] = [
            "name": name,
            "userName": userName
        ]
        
        if let image = profileImage {
            let photoName = UUID().uuidString
            guard let profileData = image.jpegData(compressionQuality: 0.5) else {
                completion(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to process image"]))
                return
            }
            
            let reference = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
            reference.putData(profileData) { storageMeta, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                reference.downloadURL { url, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    if let profilePhotoUrl = url?.absoluteString {
                        updateData["profilePhotoUrl"] = profilePhotoUrl
                    }
                    
                    Firestore.firestore().collection("users").document(uid).updateData(updateData, completion: completion)
                }
            }
        } else {
            Firestore.firestore().collection("users").document(uid).updateData(updateData, completion: completion)
        }
    }
    
    // Update user password
    static func updatePassword(newPassword: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword, completion: completion)
    }
    
}
