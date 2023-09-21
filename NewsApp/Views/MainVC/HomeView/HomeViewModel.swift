import Foundation
import Combine

class HomeViewModel {

    var fetchedNews: News?
    var category: String = "default"
    var observerCategoryNews: Set<AnyCancellable> = []
    var observerNews: [AnyCancellable] = []
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var newsSubject = CurrentValueSubject<[Article]?, Never>(nil)
    var cancellables: Set<AnyCancellable> = []
    
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
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] news in
                self?.isLoading.value = false
                self?.fetchedNews = news
                self?.mapNewsData()
                if news.articles == nil {
                    if let message = news.message, let code = news.code {
                        print("API Error: \(message), Code: \(code)")
                    }
                }
            }
            .store(in: &observerNews)
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
                self?.fetchedNews = newsCategory
                self?.mapNewsData()
            }
            .store(in: &observerCategoryNews)
    }

    func mapNewsData() {
        let filteredArticles = self.fetchedNews?.articles?.filter {
            $0.title?.contains("[Removed]") == false
        }
        newsSubject.value = filteredArticles
    }

    
    func retrieveNews(withTitle title: String) -> Article? {
        return fetchedNews?.articles!.first(where: {$0.title == title})
    }

    func bind(isLoadingHandler: @escaping (Bool) -> Void, newsHandler: @escaping ([Article]?) -> Void) {
        
        isLoading
            .sink { isLoading in
                DispatchQueue.main.async {
                    isLoadingHandler(isLoading)
                }
            }
            .store(in: &cancellables)

        newsSubject
            .sink { news in
                DispatchQueue.main.async {
                    newsHandler(news)
                }
            }
            .store(in: &cancellables)
    }
}
