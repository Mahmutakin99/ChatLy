//
//  ProfileView.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 09/08/2025.
//

import UIKit
import FirebaseAuth
import SDWebImage

protocol ProfileViewProtocol: AnyObject {
    func signOutProfile()
}

class ProfileView: UIView {
    // MARK: Properties
    var user: User?{
        didSet{ configure() }
    }
    weak var delegate: ProfileViewProtocol?
    private let profilePhotoView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2.5
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Çıkış", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSignOutButton), for: .touchUpInside)
        return button
        
    }()
    private lazy var stackView = UIStackView()
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: Helpers
extension ProfileView {
    private func style(){
        backgroundColor = .systemBlue
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.layer.cornerRadius = 120 / 2
        
        stackView = UIStackView(arrangedSubviews: [nameLabel, userNameLabel, signOutButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    private func layout(){
        addSubview(profilePhotoView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            profilePhotoView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            profilePhotoView.widthAnchor.constraint(equalToConstant: 120),
            profilePhotoView.heightAnchor.constraint(equalToConstant: 120),
            profilePhotoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: profilePhotoView.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12),
        ])
    }
    
    private func attributedTitle(headerTitle: String, title: String) -> NSMutableAttributedString{
        let attributed = NSMutableAttributedString(string: "\(headerTitle): ", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7), .font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        attributed.append(NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .heavy)]))
        
        return attributed
    }
    private func configure(){
        guard let user = self.user else { return }
        self.nameLabel.attributedText = attributedTitle(headerTitle: "Ad", title: "\(user.name)")
        self.userNameLabel.attributedText = attributedTitle(headerTitle: "Kullanıcı Adı", title: "\(user.userName)")
        self.profilePhotoView.sd_setImage(with: URL(string: user.profilePhotoUrl))
    }
}
// MARK: Selector
extension ProfileView{
    @objc func handleSignOutButton(_ sender: UIButton){
        delegate?.signOutProfile()
    }
}
