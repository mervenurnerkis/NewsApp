//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 15.09.2023.
//

import UIKit

class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteNews: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    func loadFavorites() {
        favoriteNews.removeAll()
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            if key.starts(with: "favorite_") {
                if let savedData = UserDefaults.standard.value(forKey: key) as? Data,
                   let decodedNews = try? JSONDecoder().decode(Article.self, from: savedData) {
                    favoriteNews.append(decodedNews)
                }
            }
        }
        favoriteTableView.reloadData()
    }
    
    // ... diğer kodlar

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let article = favoriteNews[indexPath.row]
        cell.configure(with: article)
        return cell
    }


}

