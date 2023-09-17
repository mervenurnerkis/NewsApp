//
//  Category.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 17.09.2023.
//

import Foundation

enum NewsCategory: String, CaseIterable {
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case technology = "Technology"
    
    var categoryName: String {
        switch self {
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .health:
            return "health"
        case .science:
            return "science"
        case .technology:
            return "technology"
        
        }
    }
}
