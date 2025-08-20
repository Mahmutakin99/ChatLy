import UIKit
import SDWebImage
import FirebaseAuth

class UserCell: UITableViewCell {
    
    //MARK: Properties
    
    var user: User?{
        didSet{
            configureUserCell()
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let title: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Title"
        
        return label
    }()
    
    private let subTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "SubTitle"
        
        return label
    }()
    
    private var stackView = UIStackView()
    
    //MARK: LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Helpers
extension UserCell {
    
    private func setup(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 55 / 2
        
        stackView = UIStackView(arrangedSubviews: [title, subTitle])
        stackView.axis = .vertical
        //stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 55),
            profileImageView.widthAnchor.constraint(equalToConstant: 55),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 4),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            //stackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            
        ])
    }
    
    private func configureUserCell(){
        guard let user = user else { return }
        if user.uid == Auth.auth().currentUser?.uid {
            self.title.text = "\(user.name) (siz)"
        } else {
            self.title.text = user.name
        }
        self.profileImageView.sd_setImage(with: URL(string: user.profilePhotoUrl))
        self.subTitle.text = user.userName
    }
}
