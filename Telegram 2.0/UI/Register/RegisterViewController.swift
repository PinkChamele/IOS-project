import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: BaseController {

    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    
    let authorizationService = AuthorizationApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        emailField.default()
        passwordField.default()
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
    
    @IBAction func signUpAction(_ sender: Any) {
        do {
            let email = try emailField.validatedText(of: .email)
            let password = try passwordField.validatedText(of: .password())
            let requestData = AuthorizationRequest(email: email, password: password)
            authorizationService.register(data: requestData) { [weak self] _ in
                self?.authorizationService.login(data: requestData) { _ in
                    self?.navVC?.setRootVC(RoomListViewController())
                } error: { [weak self]  error in
                    self?.showAlert(text: error.localizedDescription, isSuccess: false)
                }
            } error: { [weak self]  error in
                self?.showAlert(text: error.localizedDescription, isSuccess: false)
            }
        } catch let error {
            let message = (error as! ValidationError).message
            showAlert(text: message, isSuccess: false)
        }
      
    }
    
    @IBAction func signInAction(_ sender: Any) {
        popController()
    }
    @IBAction func backAction(_ sender: Any) {
       popController()
    }
}
