import UIKit
import SkyFloatingLabelTextField

class LoginViewController: BaseController {

    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func forgotPasswordAction(_ sender: Any) {
        showEmailResetPasswordAlert()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        navVC?.setRootVC(RoomListViewController())
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
        }))
        
        alert.modalPresentationStyle = .fullScreen
        self.present(alert, animated: true)
    }
}
