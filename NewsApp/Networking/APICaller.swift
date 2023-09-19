import Foundation
import Combine

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {

    static let shared = APICaller()
    
 /*   static func fetchData(completionHandler: @escaping (_ result: Result<News, NetworkError>) -> Void ) {
        
        
        
        let urlString = NetworkConstant.shared.serverAdress +
                "v2/top-headlines?country=us&apiKey=" +
                NetworkConstant.shared.apiKey
                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(News.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()

    } */
    
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
    
    static func fetchCategoryData(categories: String,completionHandler: @escaping (_ result: Result<News, NetworkError>) -> Void ) {
        
        
        var categories: String = "default"
        
        let urlString = NetworkConstant.shared.serverAdress +
                "v2/everything?q=\(categories)&apiKey=" +
                NetworkConstant.shared.apiKey

                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(News.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()

    }
    
}
