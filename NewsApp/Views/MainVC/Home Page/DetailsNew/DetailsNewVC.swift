import UIKit
import SDWebImage

class DetailsNewVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!  // Favori butonu
    
    var viewModel: DetailsNewsViewModel
    
    init(viewModel: DetailsNewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsNewVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        checkIfFavorite()
        

        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
    }
    
    
    @IBAction func favoriButtonTapped(_ sender: UIButton) {
        print("Favori butonuna tıklandı")
        let isFavorite = UserDefaults.standard.bool(forKey: viewModel.newsTitle)
        UserDefaults.standard.set(!isFavorite, forKey: viewModel.newsTitle)
        checkIfFavorite()
        
        
        if !isFavorite {
            if let encoded = try? JSONEncoder().encode(viewModel.newData) {
                UserDefaults.standard.set(encoded, forKey: "favorite_\(viewModel.newsTitle)")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: "favorite_\(viewModel.newsTitle)")
        }
    }
    
    
    func configView() {
        self.title = "News Details"
        newsTitle.text = viewModel.newsTitle
        newsDescription.text = viewModel.newsDescription
        imageView.sd_setImage(with: viewModel.newsImage, completed: nil)
    }
    
    func toggleFavorite() {
        var favorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        if favorites.contains(viewModel.newsTitle) {
            favorites.removeAll(where: { $0 == viewModel.newsTitle })
        } else {
            favorites.append(viewModel.newsTitle)
        }
        UserDefaults.standard.set(favorites, forKey: "favorites")
        checkIfFavorite()
    }
    
    func checkIfFavorite() {
        let isFavorite = UserDefaults.standard.bool(forKey: viewModel.newsTitle)
        if isFavorite == false {
            favoriteButton.setImage((UIImage(systemName: "heart")), for: .normal)
        } else {

            favoriteButton.setImage((UIImage(systemName: "heart.fill")), for: .normal)
        }
    }

}
