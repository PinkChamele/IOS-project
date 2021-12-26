import UIKit
import SkyFloatingLabelTextField

class ResetPasswordViewController: BaseController {
    
    @IBOutlet weak var newPasswordField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordField: SkyFloatingLabelTextField!
    
    let authorizationService = AuthorizationApiService()
    
    let token: String
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newPasswordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc func textDidChange(_ sender: SkyFloatingLabelTextField) {
        if sender == newPasswordField {
            sender.updateValidationResult(with: .password())
        } else if sender == confirmPasswordField {
            let pass = newPasswordField.text
            sender.updateValidationResult(with: .password(confirmPassword: pass))
        }
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        do {
            let pass = try newPasswordField.validatedText(of: .password())
            try confirmPasswordField.validatedText(of: .password(confirmPassword: pass))
            authorizationService.confirmResetPassword(data: .init(token: token, password: pass)) { _ in
                self.showAlert(text: "Your password has been successfully changed")
                self.dismiss(animated: true)
            } error: { error in
                self.showAlert(text: error.localizedDescription, isSuccess: false)
            }
        } catch let error {
            let message = (error as! ValidationError).message
            showAlert(text: message, isSuccess: false)
        }
        
    }
    
}
