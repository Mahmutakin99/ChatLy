struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    
    var status: Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
    
}
