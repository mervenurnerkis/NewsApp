//
//  NewTableCellViewModel.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 8.09.2023.
//

import Foundation
import SDWebImage

class NewTableCellViewModel {

    var title: String
    var description: String
    var imageUrl: URL?
    var imageData: Data? = nil
    
    init(news: Article) {
        self.title = news.title
        self.description = news.description ?? ""
        self.imageUrl = URL(string: news.urlToImage ?? "")  // Doğrudan API'dan alınan urlToImage'ı kullan
    }
}
