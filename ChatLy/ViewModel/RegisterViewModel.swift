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
