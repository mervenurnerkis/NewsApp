import Foundation
import Firebase

class LoginViewModel {
    
    struct userLoginKeys {
        static let userLogin = "isLogin"
    }
    
    let defaults = UserDefaults.standard

    func loginUser(email: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, let password = password else {
            completion(false, "Email and Password must not be empty.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            }
            else {
                self.saveLogging(true)
                UserDefaults.standard.set(true, forKey: "isloggedin")
                completion(true, nil)
            }
        }
    }

    
    func saveLogging(_ isLogin:Bool) {
        defaults.set(isLogin, forKey: userLoginKeys.userLogin)
        defaults.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: userLoginKeys.userLogin)
    }
}
