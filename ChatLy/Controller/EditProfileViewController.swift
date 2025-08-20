import UIKit
import FirebaseAuth
import SDWebImage

protocol EditProfileViewControllerDelegate: AnyObject {
    func editProfileViewControllerDidDismiss(_ controller: EditProfileViewController)
    func editProfileViewControllerDidUpdateProfile(_ controller: EditProfileViewController)
}

class EditProfileViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: EditProfileViewControllerDelegate?
    private var currentUser: User
    private var selectedImage: UIImage?
    private var originalBackgroundTransform: CGAffineTransform = .identity
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let handleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    fileprivate let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2.5
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickImage)))
        return imageView
    }()
    
    fileprivate lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        return button
    }()
    
    fileprivate let nameField: CustomTextField = {
        let tf = CustomTextField(placeHolder: "Ad")
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "Ad", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        tf.translatesAutoresizingMaskIntoConstraints = false
        // İç padding ekleme
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.rightView = rightPaddingView
        tf.rightViewMode = .always
        return tf
    }()
    
    fileprivate let usernameField: CustomTextField = {
        let tf = CustomTextField(placeHolder: "Kullanıcı Adı")
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        tf.translatesAutoresizingMaskIntoConstraints = false
        // İç padding ekleme
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.rightView = rightPaddingView
        tf.rightViewMode = .always
        return tf
    }()
    
    fileprivate let passwordField: CustomTextField = {
        let tf = CustomTextField(placeHolder: "Yeni Şifre (isteğe bağlı)")
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "Yeni Şifre (isteğe bağlı)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        tf.translatesAutoresizingMaskIntoConstraints = false
        // İç padding ekleme
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.rightView = rightPaddingView
        tf.rightViewMode = .always
        return tf
    }()
    
    fileprivate lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kaydet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        configureWithCurrentUser()
        setupGestureRecognizers()
        hideKeyboardWhenTappedAroundTable()
    }
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func layout() {
        view.addSubview(containerView)
        containerView.addSubview(handleView)
        containerView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(changePhotoButton)
        contentView.addSubview(nameField)
        contentView.addSubview(usernameField)
        contentView.addSubview(passwordField)
        contentView.addSubview(saveButton)
        
        layoutConstraints()
        setupTextFieldDelegates()
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            handleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            handleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 40),
            handleView.heightAnchor.constraint(equalToConstant: 5),
            
            scrollView.topAnchor.constraint(equalTo: handleView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            
            changePhotoButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            changePhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameField.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 32),
            nameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            usernameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            usernameField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            usernameField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            saveButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupTextFieldDelegates() {
        nameField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    private func configureWithCurrentUser() {
        nameField.text = currentUser.name
        usernameField.text = currentUser.userName
        if let profilePhotoUrl = URL(string: currentUser.profilePhotoUrl) {
            profileImageView.sd_setImage(with: profilePhotoUrl, placeholderImage: UIImage(systemName: "person.circle.fill"))
        }
    }
    
    private func setupGestureRecognizers() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerView.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Animasyon
    internal func animateIn() {
        containerView.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.containerView.transform = .identity
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    internal func animateOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        } completion: { _ in
            completion()
        }
    }
    
    // MARK: - Actions
    @objc private func handlePickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc private func handleSave() {
        guard let name = nameField.text, !name.isEmpty,
              let username = usernameField.text, !username.isEmpty else {
            showAlert(title: "Hata", message: "İsim ve kullanıcı adı gerekli")
            return
        }
        
        AuthenticationService.isUsernameAvailable(username) { [weak self] isAvailable in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if username == self.currentUser.userName || isAvailable {
                    self.performSave(name: name, username: username)
                } else {
                    self.showAlert(title: "Kullanıcı adı kullanılıyor", message: "Bu kullanıcı adı zaten kullanılıyor. Lütfen başka bir tane deneyin.")
                }
            }
        }
    }
    
    private func performSave(name: String, username: String) {
        AuthenticationService.updateUserProfile(name: name, userName: username, profileImage: selectedImage) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Güncelleme Hatası", message: error.localizedDescription)
                return
            }
            
            if let newPass = self.passwordField.text, !newPass.isEmpty {
                AuthenticationService.updatePassword(newPassword: newPass) { (err: Error?) in
                    if let err = err {
                        self.showAlert(title: "Şifre Hatası", message: err.localizedDescription)
                        return
                    }
                    self.delegate?.editProfileViewControllerDidUpdateProfile(self)
                    self.dismissWithAnimation()
                }
            } else {
                self.delegate?.editProfileViewControllerDidUpdateProfile(self)
                self.dismissWithAnimation()
            }
        }
    }
    
    private func dismissWithAnimation() {
        animateOut { [weak self] in
            guard let self = self else { return }
            self.delegate?.editProfileViewControllerDidDismiss(self)
            self.dismiss(animated: false)
        }
    }
    
    // MARK: - Gesture Handling
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            let newY = max(0, translation.y)
            containerView.transform = CGAffineTransform(translationX: 0, y: newY)
            
            let progress = 1 - (newY / view.bounds.height)
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5 * progress)
            
        case .ended, .cancelled:
            let shouldDismiss = translation.y > view.bounds.height * 0.3 || velocity.y > 500
            
            if shouldDismiss {
                dismissWithAnimation()
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                    self.containerView.transform = .identity
                    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                }
            }
            
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            usernameField.becomeFirstResponder()
        case usernameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameField {
            guard let username = textField.text, username.count >= 3 else {
                showAlert(title: "Hata", message: "Kullanıcı adı en az 3 karakter olmalıdır.")
                return
            }

            AuthenticationService.isUsernameAvailable(username) { [weak self] isAvailable in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if !isAvailable && username != self.currentUser.userName {
                        self.showAlert(title: "Kullanıcı Adı Kullanımda", message: "Bu kullanıcı adı zaten kullanılıyor. Lütfen başka bir tane deneyin.")
                    }
                }
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            selectedImage = image
            profileImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
