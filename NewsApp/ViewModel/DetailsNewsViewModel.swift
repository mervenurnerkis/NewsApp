//
//  DetailsNewsViewModel.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 8.09.2023.
//

import Foundation
import SDWebImage

class DetailsNewsViewModel {
    
    var newData: Article
    var newsImage: URL?
    var newsTitle: String
    var newsDescription: String
    
    init(article: Article) {
        self.newData = article
        self.newsTitle = article.title
        self.newsDescription = article.description ?? ""
        self.newsImage = URL(string: article.urlToImage ?? "")
    }
    
}
