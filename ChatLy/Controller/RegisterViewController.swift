import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import JGProgressHUD

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
    
    private let emailTextField = CustomTextField(placeHolder: "Email Giriniz:")
    private let nameTextField = CustomTextField(placeHolder: "Adınızı Giriniz:")
    private let userNameTextField = CustomTextField(placeHolder: "Kullanıcı Adı Giriniz:")
    private let passwordTextField: CustomTextField = {
       let textField = CustomTextField(placeHolder: "Şifre Giriniz:")
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayıt Ol", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        
        return button
    }()
    private lazy var switchToLoginPageButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Üye misiniz? (Giriş Yap Sayfasına Git)", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToLoginPage), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        hideKeyboardWhenTappedAround()
        
    }
}

//MARK: Selectors
extension RegisterViewController{
    
    @objc private func handleRegisterButton(_ sender: UIButton){
        guard let emailText = emailTextField.text else { return }
        guard let nameText = nameTextField.text else { return }
        guard let userNameText = userNameTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        //guard let profilePhoto = profilePhotoToUpload else { return }
        guard let profilePhoto = profilePhotoToUpload else {
            self.showErrorAlert(title: "Hata", message: "Lütfen bir profil fotoğrafı seçiniz.")
            return
        }
        let user = AuthenticationServiceUser(emailText: emailText, passwordText: passwordText, nameText: nameText, userNameText: userNameText)
        self.showProgressHud(showProgress: true)
        AuthenticationService.register(withUser: user, image: profilePhoto) { error in
            self.showProgressHud(showProgress: false)
            
            if let error = error {
                self.showErrorAlert(title: "Kayıt Hatası" , message: error.localizedDescription)
                return
            }
            
            self.showSuccessHud("Kayıt Başarılı!")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }else if sender == nameTextField{
            viewModel.name = sender.text
        }/*else if sender == userNameTextField{
            viewModel.userName = sender.text
        }*/
        else if sender == userNameTextField {
            viewModel.userName = sender.text
            
            guard let username = sender.text, username.count >= 3 else {
                viewModel.isUsernameAvailable = false
                registerButtonStatus()
                return
            }

            AuthenticationService.isUsernameAvailable(username) { [weak self] isAvailable in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.viewModel.isUsernameAvailable = isAvailable
                    self.registerButtonStatus()

                    if !isAvailable {
                        self.showErrorAlert(title: "Kullanıcı Adı Kullanımda", message: "Bu kullanıcı adı başka bir kullanıcı tarafından kullanılıyor, lütfen başka bir tane deneyinizi.")
                    }
                }
            }
        }
        
        else{
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
    
    @objc func handleWillShowNotification(){
        self.view.frame.origin.y = -125
    }
    
    @objc func handleWillHideNotification(){
        self.view.frame.origin.y = 0
    }
    
    private func configureSetupKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func style(){
        configureGradientLayer()
        configureSetupKeyboard()
        
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, userNameContainerView, passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        
        switchToLoginPageButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        view.addSubview(addPhotoButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPageButton)
        
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 180),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 180),
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
