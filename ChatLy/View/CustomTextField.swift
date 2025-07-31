//
//  CustomTextField.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

import UIKit

class CustomTextField: UITextField {
    init(placeHolder: String) {
         super.init(frame: .zero)
        attributedPlaceholder = NSMutableAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white])
        borderStyle = .none
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

