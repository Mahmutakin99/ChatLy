//
//  ViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {
    //MARK: Properties

    
    private var viewModel = LoginViewModel()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "appstore")
        return imageView
        
    }()
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    private let emailTextField = CustomTextField(placeHolder: "Email giriniz:")
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        
        return containerView
    }()
    private let passwordTextField: CustomTextField = {
       let textField = CustomTextField(placeHolder: "Şifrenizi giriniz:")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var stackView = UIStackView()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş yap", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var switchToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Üye Olmak İçin Tıklayın", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegisterPage), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradientLayer()
        style()
        layout()
        hideKeyboardWhenTappedAround()
    }
}

//MARK: Selector
extension LoginViewController {
    
    @objc func handleLoginButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        showProgressHud(showProgress: true)
        
        AuthenticationService.login(withEmail: emailText, password: passwordText) { result, error in
            DispatchQueue.main.async {
                self.showProgressHud(showProgress: false)
                
                if let error = error {
                    self.showProgressHud(showProgress: false)
                    self.showErrorAlert(message: error.localizedDescription)
                    return
                }
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.emailTextField = sender.text
        }else{
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    @objc private func handleGoToRegisterPage(_ sender: UIButton) {
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: Helpers
extension LoginViewController {

    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func loginButtonStatus(){
        if viewModel.status{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        switchToRegisterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchToRegisterButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.heightAnchor.constraint(equalToConstant: 190),
            logoImageView.widthAnchor.constraint(equalToConstant: 175),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            //stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToRegisterButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            switchToRegisterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToRegisterButton.trailingAnchor, constant: 32),
        
        ])
    }
}
