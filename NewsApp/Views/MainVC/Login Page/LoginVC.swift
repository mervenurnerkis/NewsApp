import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    
    @IBAction func loginClicked(_ sender: UIButton) {
        loginViewModel.loginUser(email: mailTextField.text, password: passwordTextField.text) { success, error in
            if success {
                let main = UIStoryboard(name: "HomeVC", bundle: nil)
                let home = main.instantiateViewController(withIdentifier: "TabbarVC")
                self.present(home, animated: true, completion: nil)
            } else if let error = error {
                // Show error alert
                let alertController = UIAlertController(title: "Giriş Başarısız", message: error, preferredStyle: .alert)
                 
                let actionOk = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                 
                alertController.addAction(actionOk)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
