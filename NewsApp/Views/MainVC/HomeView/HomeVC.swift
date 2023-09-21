import UIKit
import Combine

class HomeVC: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndıcator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backViewSide: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    var homeViewModel: HomeViewModel = HomeViewModel()
    var searchKeyword = ""
    let searchVC = UISearchController(searchResultsController: nil)
    var articles: [Article] = []
    var category: String = "default"
    var isMenuOpen: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
        backViewSide.isHidden = true
        isMenuOpen = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        homeViewModel.getData()
        homeViewModel.getCategoryData(category: self.category)
    }
    
    
    @IBAction func showSideMenu(_ sender: Any) {
        backViewSide.isHidden = false
        tableView.isHidden = false
        
        if !isMenuOpen {
            isMenuOpen = true
            backViewSide.frame = CGRect(x: 0, y: 88, width: 0, height: 808)
            tableView.frame = CGRect(x: 0, y: 88, width: 0, height: 808)
            UIView.animate(withDuration: 0.5) {
                self.backViewSide.frame = CGRect(x: 0, y: 88, width: 240, height: 808)
            }
            
        }else {
            backViewSide.isHidden = true
            tableView.isHidden = false
            isMenuOpen = false
            backViewSide.frame = CGRect(x: 0, y: 88, width: 0, height: 808)
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 808)
            UIView.animate(withDuration: 1) {
                self.backViewSide.frame = CGRect(x: 0, y: 88, width: 240, height: 808)
            }
        }
        
    }
    
    func configView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.registerCells()
    }
    
    func bindViewModel() {
        homeViewModel.bind(isLoadingHandler: { [weak self] isLoading in
            if isLoading {
                self?.activityIndıcator.startAnimating()
                self?.activityIndıcator.isHidden = false
            } else {
                self?.activityIndıcator.stopAnimating()
                self?.activityIndıcator.isHidden = true
            }
        }, newsHandler: { [weak self] news in
            guard let news = news else { return }
            self?.articles = news
            self?.reloadTableView()
            self?.activityIndıcator.stopAnimating()
        })
    }

    
    func openDetail(newId: String) {
        guard let news = homeViewModel.retrieveNews(withTitle: newId) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsNewsViewModel(article: news)
            let detailsController = DetailsNewVC(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchKeyword = searchText
        filterNews()
    }
    
    func filterNews() {
        guard !searchKeyword.isEmpty else {
            self.articles = homeViewModel.newsSubject.value ?? []
            reloadTableView()
            return
        }
        
        self.articles = homeViewModel.newsSubject.value?.filter { viewModel in
            return viewModel.title!.lowercased().contains(searchKeyword.lowercased())
        } ?? []
        
        reloadTableView()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func registerCells() {
        tableView.register(HomeNewCell.register(), forCellReuseIdentifier: HomeNewCell.identifier)
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewCell.identifier, for: indexPath) as! HomeNewCell
        let article = articles[indexPath.row]
        cell.setupCell(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNewTitle = articles[indexPath.row].title
        self.openDetail(newId: selectedNewTitle!)
    }
}
