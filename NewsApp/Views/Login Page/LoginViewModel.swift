import Foundation
import Firebase

class LoginViewModel {
    
    let defaults = UserDefaults.standard

    func loginUser(email: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
        guard let email = email, let password = password else {
            completion(false, Constants.emptyCredentialsError)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            }
            else {
                self.saveLogging(true)
                UserDefaults.standard.set(true, forKey: Constants.isUserLoggedIn)
                completion(true, nil)
            }
        }
    }

    func saveLogging(_ isLogin: Bool) {
        defaults.set(isLogin, forKey: Constants.isUserLoggedIn)
        defaults.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: Constants.isUserLoggedIn)
    }
}

