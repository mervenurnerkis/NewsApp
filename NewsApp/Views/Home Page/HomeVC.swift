import UIKit
import SideMenu

class HomeVC: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndıcator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var backViewSide: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    var homeViewModel: HomeViewModel = HomeViewModel()
    
    var cellDataSource: [NewTableCellViewModel] = []
    
    var searchKeyword = ""
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    var articles: [Article] = []
    
    var categories: String = "default"
    
    //    func getCategories(categories: String) -> String {
    //        "https://newsapi.org/v2/everything?q=\(self.categories)&apiKey=027c4dbd555e4ebfb1db490cdbbd9c3d"
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
        // createSearchBar()
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        backViewSide.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViewModel.getData()
        homeViewModel.getCategoriesData()
    }
    
    
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "ISLOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        var isChecked = true
        
        if isChecked {
            backViewSide.isHidden = true
        } else {
            backViewSide.isHidden = false
        }
        
    }
    
    
    func configView() {
        
        setupTableView()
    }
    
    func bindViewModel() {
        homeViewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndıcator.startAnimating()
                } else {
                    self.activityIndıcator.stopAnimating()
                }
            }
        }
        
        homeViewModel.news.bind { [weak self] news in
            guard let self = self,
                  let news = news else {
                return
            }
            self.cellDataSource = news
            self.reloadTableView()
        }
        
    }
    
    func openDetail(newId: String) {
        guard let news = homeViewModel.retriveMovie(withId: newId) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsNewsViewModel(article: news)
            let detailsController = DetailsNewVC(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    /* func createSearchBar() {
     searchVC.searchBar.delegate = self
     navigationItem.searchController = searchVC
     } */
    
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
//    func getCategoryNews() {
//        APICaller.shared.fetchCategoryData(completionHandler: { articles in
//            self.articles = articles
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        })
//
//
//    }
    
}

