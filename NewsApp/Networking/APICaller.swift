import Foundation
import Combine

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {

    static let shared = APICaller()
    
    static func fetchData() -> AnyPublisher<News, Error> {
        let apiKey = NetworkConstant.shared.apiKey

        var urlComponents = URLComponents(string: NetworkConstant.shared.serverAdress + "v2/top-headlines")!
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
       
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchCategoryData(category: String) -> AnyPublisher<News, Error> {
        
        let urlString = NetworkConstant.shared.serverAdress +
            "v2/everything"
        
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: category),
            URLQueryItem(name: "apiKey", value: NetworkConstant.shared.apiKey)
        ]
        
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .map(\.data)
            .decode(type: News.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
