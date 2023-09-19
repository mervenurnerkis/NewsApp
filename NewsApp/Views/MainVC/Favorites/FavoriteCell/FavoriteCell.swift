//
//  FavoriteCell.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 16.09.2023.
//

import UIKit
import SDWebImage

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description ?? ""
        
        if let imageUrl = URL(string: article.urlToImage ?? "") {
            favoriteImage.sd_setImage(with: imageUrl, completed: nil)
        } else {
            favoriteImage.image = nil
        }
    }
}

