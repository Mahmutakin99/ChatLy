//
//  RegisterViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 31/07/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    //MARK: Properties
    
    private var profilePhotoToUpload: UIImage?
    
    private var viewModel = RegisterViewModel()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.viewfinder"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        
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
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = 10
        //email ve şifre girilmeden basılmaması için
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        
        return button
    }()
    private lazy var switchToLoginPageButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "If You Are A Member, Login Page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToLoginPage), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styl()
        layout()
        
    }
}

//MARK: Selectors
extension RegisterViewController{
    
    @objc private func handleRegisterButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else { return }
        guard let nameText = nameTextField.text else { return }
        guard let userNameText = userNameTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        guard let profilePhoto = profilePhotoToUpload else { return }
        
        let photoName = UUID().uuidString
        guard let profileData = profilePhoto.jpegData(compressionQuality: 0.5) else { return }
        let referance = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
        referance.putData(profileData) { storegeMeta, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }
            referance.downloadURL { url, error in
                if let error = error{
                    print("Error: \(error.localizedDescription)")
                }
                guard let profilePhotoUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: emailText, password: passwordText) { result, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    guard let userUid = result?.user.uid else { return }
                    let data = [
                        "email": emailText,
                        "name": nameText,
                        "userName": userNameText,
                        "profilePhotoUrl": profilePhotoUrl,
                        "uid": userUid,
                        
                    ] as [String: Any]
                    Firestore.firestore().collection("users").document(userUid).setData(data) { error in
                        if let error = error{
                            print(error.localizedDescription)
                        }
                        print("Profil oluşturma işlemi başarılı")
                    }
                }
            }
        }
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == nameTextField{
            viewModel.name = sender.text
        }else if sender == userNameTextField{
            viewModel.userName = sender.text
        }else{
            viewModel.password = sender.text
        }
        registerButtonStatus()
    }
    
    @objc func handleGoToLoginPage(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handlePhoto(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
}


//MARK: Helpers
extension RegisterViewController{
    
    private func registerButtonStatus(){
        if viewModel.status{
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemBlue
        }else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
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
        
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        
        //switchToLoginPage
        switchToLoginPageButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(addPhotoButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPageButton)
        
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 190),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 175),
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToLoginPageButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            switchToLoginPageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            view.trailingAnchor.constraint(equalTo: switchToLoginPageButton.trailingAnchor, constant: 32),
            
            
        ])
    }
}
//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profilePhotoToUpload = image
        addPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.cornerRadius = 180 / 2
        addPhotoButton.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
}
