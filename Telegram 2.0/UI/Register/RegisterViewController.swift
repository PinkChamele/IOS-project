import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: BaseController {

    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func signUpAction(_ sender: Any) {
        navVC?.setRootVC(RoomListViewController())
    }
    
    @IBAction func signInAction(_ sender: Any) {
        popController()
    }
}
