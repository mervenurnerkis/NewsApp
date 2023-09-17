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
                    favoriteTableView.reloadData()
                }
            }
        }
       // favoriteNews.removeAll()
        
    }
    
    // ... diğer kodlar

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        if indexPath.row < favoriteNews.count {
            let article = favoriteNews[indexPath.row]
            cell.configure(with: article)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row < favoriteNews.count {
                // Lokal array'den sil
                let article = favoriteNews[indexPath.row]
                favoriteNews.remove(at: indexPath.row)
                
                // UserDefaults'dan ilgili favori haberin anahtarını sil
                if let title = article.title {
                    UserDefaults.standard.removeObject(forKey: "favorite_\(title)")
                }

                // TableView'dan sil
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }

    
    func updateFavoriteArticles() {
        // Elinizdeki tüm haberler (örneğin, `allArticles` adında bir dizi)
        let allArticles:[Article] = []

        favoriteNews = allArticles.filter { article in
            return UserDefaults.standard.bool(forKey: article.title!)
        }
    }
    
    func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteNews) {
            UserDefaults.standard.set(encoded, forKey: "favoriteNews")
        }
        
        
    }
}

