//  ProfilVC.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 10.09.2023.
//

import UIKit

class ProfilVC: UIViewController {

    @IBOutlet weak var switchTheme: UISwitch!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            let darkMode = UserDefaults.standard.bool(forKey: "darkMode")
            switchTheme.isOn = darkMode
            updateTheme(isDarkMode: darkMode)
        }
    }
    
    @IBAction func switchThemeValueChanged(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            updateTheme(isDarkMode: sender.isOn)
        }
    }
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isloggedin")
        
        let storyboard = UIStoryboard(name: "OnboardingVC", bundle: nil)
        if let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingVC") as? OnboardingVC {
            let navigationController = UINavigationController(rootViewController: onboardingVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func updateTheme(isDarkMode: Bool) {
        UserDefaults.standard.set(isDarkMode, forKey: "darkMode")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let appDelegate = windowScene.windows.first {
            appDelegate.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
