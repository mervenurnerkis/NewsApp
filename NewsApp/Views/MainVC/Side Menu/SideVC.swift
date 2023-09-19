//  SideVC.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 17.09.2023.
//

import UIKit

class SideVC: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self

 
    }

}
extension SideVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCategory.allCases.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        cell.categoryLabel.text = NewsCategory.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = NewsCategory.allCases[indexPath.row].rawValue
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            vc.homeViewModel.getCategoriesData(categories: category)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }


    
}
