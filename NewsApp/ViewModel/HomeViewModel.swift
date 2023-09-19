//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation
import Combine

class HomeViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var news: Observable<[NewTableCellViewModel]> = Observable(nil)
    var dataSource: News?
    
    var categories: String = "default"
    
    var observerNews: [AnyCancellable] = []
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return self.dataSource?.articles.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
//        APICaller.fetchData { [weak self] result in
//            self?.isLoading.value = false
//
//            switch result {
//            case .success(let trendingMovieData):
//                self?.dataSource = trendingMovieData
//                self?.mapMovieData()
//            case .failure(let err):
//                print(err)
//            }
//        }
        APICaller.fetchData()
            .receive(on: DispatchQueue.main) // runs main thread
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("\(error)")
                }
            } receiveValue: { [weak self] news in
                self?.isLoading.value = false
                self?.dataSource = news
                self?.mapNewsData()
            }.store(in: &observerNews)
    }
    
    func getCategoriesData(categories: String) {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        APICaller.fetchCategoryData(categories: categories) { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let NewsCategory):
                self?.dataSource = NewsCategory
                self?.mapNewsData()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func mapNewsData() {
        news.value = self.dataSource?.articles.compactMap({NewTableCellViewModel(news: $0)})
    }
    
//    func getMovieTitle(_ articles: Article) -> String {
//        return articles.title ??  ""
//    }
    
    func retriveNews(withId title: String) -> Article? {
        guard let movie = dataSource?.articles.first(where: {$0.title == title}) else {
            return nil
        }
        
        return movie
    }
}
