//
//  News.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation

struct News: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
   // let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
   // let publishedAt: Date
  //  let content: String
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}