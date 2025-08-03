//
//  ViewController.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: Properties
    
    private var viewModel = LoginViewModel()
    
    // logomuzu uygulamamızın üzerinde gösterme
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        // görüntüyü bozmadan oranı koruyarak büyütme
        imageView.contentMode = .scaleAspectFill
        //resmin dışına çıkan kısımları kırpar
        imageView.clipsToBounds = true
        // oluşturduğum logoyu imageView'a ekliyorum
        imageView.image = #imageLiteral(resourceName: "appstore")
        return imageView
        
    }()
    //emailContainerView
    //kullanıcının email bölümünü boş bırakması halinde bu kısım için bellekte yer açılmaması için lazy var kullanıldı
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        
        return containerView
    }()
    private let emailTextField = CustomTextField(placeHolder: "Enter Your Email:")
    
    //passwordContainerView
    //kullanıcının email bölümünü boş bırakması halinde bu kısım için bellekte yer açılmaması için lazy var kullanıldı
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        
        return containerView
    }()
    private let passwordTextField: CustomTextField = {
       let textField = CustomTextField(placeHolder: "Enter Your Password:")
        //şifrenin gösterilmemesi için
        textField.isSecureTextEntry = true
        return textField
    }()
    
    //stackView
    private var stackView = UIStackView()
    
    //Login butonu
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = 10
        //email ve şifre girilmeden basılmaması için
        button.isEnabled = false
        
        return button
    }()
    
    //register sayfasına geçiş butonu
    private lazy var switchToRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click To Become A Member", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegisterPage), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // login ekranımızın arkaplanının değiştiği fonksiyonu çağırıyoruz
        configureGradientLayer()
        style()
        layout()
        
    }


}

//MARK: Selector
extension LoginViewController {
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
        //logoImageView
        //otomatik düzenlemeyi kapatır
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        //emailContainerView
        //otomatik düzenlemeyi kapatır
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        //stack içerisindeki elemanların hepsinin büyüklüğünü aynı yapar
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //email/passwordTextFiel
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        //switchToRegisterButton
        switchToRegisterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        //logoImageView'ı, emailContainerView'ı view'a ekliyoruz
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchToRegisterButton)
        
        //logomuzun ve email bölümünün ekrandaki konumunu ayarlıyoruz
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
