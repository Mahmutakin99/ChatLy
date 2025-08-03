//
//  AppDelegate.swift
//  ChatLy
//
//  Created by MAHMUT AKIN on 30/07/2025.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // programımızın pencere oluşturuyoruz
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        // giriş sayfası olarak hangi controller sayfasını seçeceğimizi belirliyoruz
        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        //pencereyi aktif ve görünür hale getirme
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        return true
    }

    


}


