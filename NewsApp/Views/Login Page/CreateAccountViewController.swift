//
//  CreateAccountViewController.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func createClicked(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let a = error {
                print("error")
            }
            else {
                // Go to our home screen
            }
            
        }
    }
    

}
