import UIKit
import SideMenu
import Combine

class HomeVC: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndıcator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var backViewSide: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    var homeViewModel: HomeViewModel = HomeViewModel()
    
    var cellDataSource: [NewTableCellModel] = []
    
    var searchKeyword = ""
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    var articles: [Article] = []
    
    var category: String = "default"
    
    var isMenuOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
        backViewSide.isHidden = true
        isMenuOpen = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        setupTableView()
    }
    
    var cancellables: Set<AnyCancellable> = []  
    
    func bindViewModel() {
        
        homeViewModel.isLoading
            .sink { [weak self] isLoading in
                DispatchQueue.main.async {
                    if isLoading {
                        self?.activityIndıcator.startAnimating()
                        self?.activityIndıcator.isHidden = false // Görünür yap
                    } else {
                        self?.activityIndıcator.stopAnimating()
                        self?.activityIndıcator.isHidden = true  // Görünmez yap
                    }
                }
            }
            .store(in: &cancellables)

        
        homeViewModel.news
            .sink { [weak self] news in
                DispatchQueue.main.async {
                    guard let news = news else { return }
                    self?.cellDataSource = news
                    self?.reloadTableView()
                    self?.activityIndıcator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
    }
    
    func openDetail(newId: String) {
        guard let news = homeViewModel.retriveNews(withId: newId) else {
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
            self.cellDataSource = homeViewModel.news.value ?? []
            reloadTableView()
            return
        }
        
        self.cellDataSource = homeViewModel.news.value?.filter { viewModel in
            return viewModel.title.lowercased().contains(searchKeyword.lowercased())
        } ?? []
        
        reloadTableView()
    }
    
}
