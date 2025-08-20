import UIKit
import SDWebImage

class MessageCell: UITableViewCell {
    // MARK: Properties
    var lastUser: LastUser? {
        didSet { configureMessageCell()  }
    }
    private let profilePhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemCyan
        
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private var stackView = UIStackView()
    private let timestampLabel: UILabel = {
       let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 15, weight: .light)
        
        return timeLabel
    }()
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: Helpers
extension MessageCell {
    
    private func setup(){
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.layer.cornerRadius = 55 / 2
        
        stackView = UIStackView(arrangedSubviews: [usernameLabel, lastMessageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(profilePhotoView)
        addSubview(stackView)
        addSubview(timestampLabel)
        
        NSLayoutConstraint.activate([
            profilePhotoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profilePhotoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profilePhotoView.heightAnchor.constraint(equalToConstant: 55),
            profilePhotoView.widthAnchor.constraint(equalToConstant: 55),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profilePhotoView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12),
            
            timestampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: timestampLabel.trailingAnchor, constant: 8),
        ])
    }
    private func configureMessageCell(){
        guard let lastUser = self.lastUser else { return }
        let viewModel = MessageViewModel(lastUser: lastUser)
        self.usernameLabel.text = lastUser.user.userName
        self.lastMessageLabel.text = lastUser.message.text
        self.profilePhotoView.sd_setImage(with: viewModel.profilePhoto)
        self.timestampLabel.text = viewModel.timestampString
    }
}
