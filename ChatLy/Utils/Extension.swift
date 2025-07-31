//
//  Extension.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

import UIKit

extension UIViewController {
    // login ekranımızın arkaplanının değiştiği fonksiyon
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        // boyutunu ekran boyutuna göre otomatik ayarlama
        gradient.frame = view.bounds
        // view'a ekliyoruz
        view.layer.addSublayer(gradient)
    }
}
