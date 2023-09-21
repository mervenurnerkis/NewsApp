//
//  News.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation

struct News: Codable {
    let articles: [Article]?
    let message: String?
    let code: String?
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
