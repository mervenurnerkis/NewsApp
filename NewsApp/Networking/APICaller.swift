import Foundation
import Combine

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {

    static let shared = APICaller()
    
    static func fetchData() -> AnyPublisher<News, Error> {
        
        var urlComponents = URLComponents(string: Address.topHeadLines.rawValue)!
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: NetworkConstant.apiKey)
        ]
       
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchCategoryData(category: String) -> AnyPublisher<News, Error> {
        
        var urlComponents = URLComponents(string: Address.everything.rawValue)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: category),
            URLQueryItem(name: "apiKey", value: NetworkConstant.apiKey)
        ]
        
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
