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
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let a = error {
                print("error")
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
