//
//  NetworkConstant.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation

class NetworkConstant {
    
    public static var shared: NetworkConstant = NetworkConstant()
    
    public var apiKey: String {
        get {
            return "027c4dbd555e4ebfb1db490cdbbd9c3d"
        }
    }
    
    public var serverAdress: String {
        get {
            return "https://newsapi.org/"
        }
    }
    
    public var imageServerAdress: String {
        get {
            return "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=027c4dbd555e4ebfb1db490cdbbd9c3d"
        }
    }
    
    public static var searchUrlAdress: String {
        get {
            return "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=661568f9076748639622adc1d4b58bf9&q="
       // https://newsapi.org/v2/top-headlines?category=business&apiKey=027c4dbd555e4ebfb1db490cdbbd9c3d
        }
    }
}
