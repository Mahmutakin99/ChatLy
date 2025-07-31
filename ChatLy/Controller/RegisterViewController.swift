//
//  RegisterViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 31/07/2025.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: Properties
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.viewfinder"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    private lazy var nameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        
        return containerView
    }()
    private lazy var userNameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person.fill")!, textField: userNameTextField)
        
        return containerView
    }()
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Enter Your Email:")
    private let nameTextField = CustomTextField(placeHolder: "Enter Your Name:")
    private let userNameTextField = CustomTextField(placeHolder: "Enter Your UserName:")
    private let passwordTextField: CustomTextField = {
       let textField = CustomTextField(placeHolder: "Enter Your Password:")
        //şifrenin gösterilmemesi için
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    
    //registerButton
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        //email ve şifre girilmeden basılmaması için
        button.isEnabled = false
        
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styl()
        layout()
        
    }
}
//MARK: Helpers
extension RegisterViewController{
    private func styl(){
        configureGradientLayer()
        //addPhotoButton
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, userNameContainerView, passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        //stack içerisindeki elemanların hepsinin büyüklüğünü aynı yapar
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(addPhotoButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 190),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 175),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}
