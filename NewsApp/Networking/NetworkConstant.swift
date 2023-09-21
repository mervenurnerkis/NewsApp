//
//  NetworkConstant.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation

enum Address: String {
    case topHeadLines = "https://newsapi.org/v2/top-headlines"
    case everything = "https://newsapi.org/v2/everything"
}

class NetworkConstant {
    public var shared: NetworkConstant = NetworkConstant()
    static let apiKey: String = "e5cb123197824efc9786f09bb56d69f9"
}
