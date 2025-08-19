//
//  ChatInputView.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 05/08/2025.
//

import UIKit

protocol ChatInputViewProtocol: AnyObject {
    func sendMessage(_ chatInputView: ChatInputView, message: String)
}

class ChatInputView: UIView {
    //MARK: Properties
    
    weak var delegate: ChatInputViewProtocol?
    
    private let textInputView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .title2)
        
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "paperplane")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        
        return button
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Mesajınızı giriniz:"
        label.alpha = 0.5
        return label
    }()
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideDismissKeyboard))
        addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Helpers
extension ChatInputView {
    private func style(){
        autoresizingMask = .flexibleHeight
        configureGradientLayer()
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputView), name: UITextView.textDidChangeNotification, object: nil)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout(){
        addSubview(textInputView)
        addSubview(sendButton)
        addSubview(placeHolderLabel)
        
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4),
            bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: 15),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            
            placeHolderLabel.topAnchor.constraint(equalTo: textInputView.topAnchor),
            placeHolderLabel.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor, constant: 8),
            placeHolderLabel.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: -8),
            placeHolderLabel.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor),
            
        ])
        
    }
    @objc func hideDismissKeyboard() {
        endEditing(true)
    }
    /*func clear(){
        textInputView.text = nil
        placeHolderLabel.isHidden = false
    }*/
    func clear(){
        textInputView.text = nil
        placeHolderLabel.isHidden = false
        sendButton.isEnabled = false
        sendButton.alpha = 0.5
    }
}
//MARK: Selector
extension ChatInputView{
    
    /*@objc private func handleTextInputView(){
        placeHolderLabel.isHidden = !textInputView.text.isEmpty
    }*/
    @objc private func handleTextInputView(){
        let isEmpty = textInputView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        placeHolderLabel.isHidden = !isEmpty
        sendButton.isEnabled = !isEmpty
        sendButton.alpha = isEmpty ? 0.5 : 1.0
    }
    
    @objc private func handleSendButton(_ sender: UIButton){
        guard let message = textInputView.text else { return }
        self.delegate?.sendMessage(self, message: message)
        
    }
}
