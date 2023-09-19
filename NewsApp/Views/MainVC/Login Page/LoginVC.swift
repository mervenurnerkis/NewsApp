//
//  MainVC.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 6.09.2023.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Giriş Başarısız", message: error.localizedDescription, preferredStyle: .alert)
                 
                 let actionOk = UIAlertAction(title: "Tamam",
                                              style: .default,
                                              handler: nil)
                 
                 alertController.addAction(actionOk)
                 self.present(alertController, animated: true, completion: nil)
            }
            else {
                UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
                let main = UIStoryboard(name: "HomeVC", bundle: nil)
                let home = main.instantiateViewController(withIdentifier: "TabbarVC")
                self.present(home, animated: true, completion: nil)
            }
            
        }
    }
    // MARK: Setuserlogin
    func saveLogging(_ isLogin:Bool) {
        defaults.set(isLogin, forKey: LoginInfos.userLoginKeys.userLogin)
        defaults.synchronize()
    }
    
    
    //MARK: GetUserLogin
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: LoginInfos.userLoginKeys.userLogin)
    }
}
