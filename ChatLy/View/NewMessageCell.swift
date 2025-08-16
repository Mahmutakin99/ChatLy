//
//  MessageCell.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 05/08/2025.
//

import UIKit
import SDWebImage

class NewMessageCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var messageContainerViewLeft: NSLayoutConstraint!
    var messageContainerViewRight: NSLayoutConstraint!
    
    var message: Message?{
        didSet{ configure() }
    }
    
    private let profilePhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    private let messageContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemBlue
        
        return containerView
    }()
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = "Message"
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()
    
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
extension NewMessageCell {
    
    private func style(){
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.layer.cornerRadius = 50 / 2
        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.layer.cornerRadius = 10
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(profilePhotoView)
        addSubview(messageContainerView)
        addSubview(messageTextView)
        
        NSLayoutConstraint.activate([
            profilePhotoView.widthAnchor.constraint(equalToConstant: 50),
            profilePhotoView.heightAnchor.constraint(equalToConstant: 50),
            bottomAnchor.constraint(equalTo: profilePhotoView.bottomAnchor,constant: 5),
            profilePhotoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            
            messageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            messageTextView.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor),
            
        ])
        
        self.messageContainerViewLeft = messageContainerView.leadingAnchor.constraint(equalTo: profilePhotoView.trailingAnchor, constant: 8)
        self.messageContainerViewLeft.isActive = false
        self.messageContainerViewRight = messageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        self.messageContainerViewRight.isActive = false
        
    }
    
    private func configure(){
        guard let message = self.message else { return }
        let viewModel = NewMessageViewModel(message: message)
        messageTextView.text = message.text
        messageContainerView.backgroundColor = viewModel.messageBackgroundColor
        messageContainerViewRight.isActive = viewModel.currentUserActive
        messageContainerViewLeft.isActive = !viewModel.currentUserActive
        profilePhotoView.isHidden = viewModel.currentUserActive
        profilePhotoView.sd_setImage(with: viewModel.profilePhotoView)
        
    }
}


