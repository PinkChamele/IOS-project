import UIKit
import SkyFloatingLabelTextField

class LoginViewController: BaseController {

    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    
    var authorizationService = AuthorizationApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        emailField.default()
        passwordField.default()
        passwordField.isSecureTextEntry = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func didChangeText(_ sender: SkyFloatingLabelTextField) {
        if sender == emailField {
            sender.updateValidationResult(with: .email)
        } else if sender == passwordField {
            sender.updateValidationResult(with: .password())
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        showEmailResetPasswordAlert()
    }
    
    @IBAction func signInAction(_ sender: DefaultButton) {
       do {
           let email = try emailField.validatedText(of: .email)
           let password = try passwordField.validatedText(of: .password())
           sender.setLoading()
           authorizationService.login(data: .init(email: email, password: password)) { [weak self] data in
               self?.navVC?.setRootVC(RoomListViewController())
               sender.setLoading(false)
           } error: { [weak self]  error in
               self?.showAlert(text: error.localizedDescription, isSuccess: false)
               sender.setLoading(false)
           }
       } catch let error {
           let message = (error as! ValidationError).message
           showAlert(text: message, isSuccess: false)
       }
    }

    @IBAction func signUpAction(_ sender: Any) {
        pushController(RegisterViewController())
    }
    
    func showEmailResetPasswordAlert() {
        let alert = UIAlertController(
            title: "tg.login.alert.title".localized,
            message: "tg.login.alert.message".localized,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = ""
            textField.keyboardType = .emailAddress
            textField.tag = 2
            textField.autocapitalizationType = .none
        }
        
        alert.addAction(UIAlertAction(title: "tg.cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "tg.send".localized, style: .default, handler: { [weak alert] (_) in
            let email = alert?.textFields![0].text ?? ""
            self.authorizationService.resetPassword(email: email)
        }))
        
       present(alert, animated: true, completion: nil)
    }
}
