import UIKit
import JGProgressHUD

private var progressHudKey: UInt8 = 0

extension UIViewController {
    
    func hideKeyboardWhenTappedAroundTable() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
            
        }
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private var progressHud: JGProgressHUD {
            get {
                if let hud = objc_getAssociatedObject(self, &progressHudKey) as? JGProgressHUD {
                    return hud
                } else {
                    let hud = JGProgressHUD(style: .dark)
                    objc_setAssociatedObject(self, &progressHudKey, hud, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    return hud
                }
            }
        }

        func showProgressHud(showProgress: Bool){
            progressHud.textLabel.text = "Lütfen Bekleyiniz..."
            if showProgress {
                progressHud.show(in: view)
            } else {
                progressHud.dismiss()
            }
        }
    
    func showErrorHud(_ message: String) {
        let hud = progressHud
        hud.textLabel.text = message
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: view)
        hud.dismiss(afterDelay: 2.5)
    }

    func showSuccessHud(_ message: String) {
        let hud = progressHud
        hud.textLabel.text = message
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: view)
        hud.dismiss(afterDelay: 2.5)
    }

    
    func add(_ child: UIViewController){
        addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(){
        willMove(toParent: self)
        self.view.removeFromSuperview()
        removeFromParent()
    }
    
}

extension UIView{
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}



