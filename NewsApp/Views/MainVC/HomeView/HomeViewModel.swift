//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation
import Combine

class HomeViewModel {

    var dataSource: News?
    var category: String = "default"
    var observerCategoryNews: Set<AnyCancellable> = []
    var observerNews: [AnyCancellable] = []
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var news = CurrentValueSubject<[NewTableCellModel]?, Never>(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return self.dataSource?.articles.count ?? 0
    }
    
    func getData() {
        if isLoading.value {
            return
        }
        
        isLoading.value = true
        APICaller.fetchData()
            .receive(on: DispatchQueue.main)
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
    
    func getCategoryData(category: String) {
        if isLoading.value {
            return
        }
        isLoading.value = true
        APICaller.fetchCategoryData(category: category)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("\(error)")
                    self?.isLoading.value = false
                }
            } receiveValue: { [weak self] newsCategory in
                self?.isLoading.value = false
                self?.dataSource = newsCategory
                self?.mapNewsData()
            }
            .store(in: &observerCategoryNews)
    }
    
    func mapNewsData() {
        news.value = self.dataSource?.articles.compactMap({NewTableCellModel(news: $0)})
    }
    
    func retriveNews(withId title: String) -> Article? {
        guard let news = dataSource?.articles.first(where: {$0.title == title}) else {
            return nil
        }
        return news
    }
}
