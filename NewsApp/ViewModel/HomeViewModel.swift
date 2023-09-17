//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 7.09.2023.
//

import Foundation

class HomeViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var news: Observable<[NewTableCellViewModel]> = Observable(nil)
    var dataSource: News?
    
    var categories: String = "default"
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.articles.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        APICaller.fetchData { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let trendingMovieData):
                self?.dataSource = trendingMovieData
                self?.mapMovieData()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getCategoriesData() {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        APICaller.fetchCategoryData { [weak self] result in
            self?.isLoading.value = false
            
            switch result {
            case .success(let NewsCategory):
                self?.dataSource = NewsCategory
                self?.mapMovieData()
            case .failure(let err):
                print(err)
            }
        }
    } 
    
    func mapMovieData() {
        news.value = self.dataSource?.articles.compactMap({NewTableCellViewModel(news: $0)})
    }
    
    func getMovieTitle(_ articles: Article) -> String {
        return articles.title ??  ""
    }
    
    func retriveMovie(withId title: String) -> Article? {
        guard let movie = dataSource?.articles.first(where: {$0.title == title}) else {
            return nil
        }
        
        return movie
    }
    

    // HomeVC'de


    
}
