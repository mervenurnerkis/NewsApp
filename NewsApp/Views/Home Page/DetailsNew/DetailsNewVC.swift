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
               
               // Bu satırı ekleyerek butonun tıklanabilir olduğunu doğrulayalım.
               favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("Favori butonuna tıklandı")  // Bu satırı ekleyerek butonun tıklandığını görebiliriz.
        toggleFavorite()
    }
    
    func configView() {
        self.title = "News Details"
        newsTitle.text = viewModel.newsTitle
        newsDescription.text = viewModel.newsDescription
        imageView.sd_setImage(with: viewModel.newsImage, completed: nil)
    }
    
    // Favori olup olmadığını kontrol et
    func checkIfFavorite() {
            if UserDefaults.standard.bool(forKey: viewModel.newsTitle) {
                // Favori olarak işaretlendi
                favoriteButton.setTitle("❤️", for: .normal)
            } else {
                // Favori olarak işaretlenmedi
                favoriteButton.setTitle("♡", for: .normal)
            }
        }
        
        // Favori durumunu değiştir
        func toggleFavorite() {
            let isFavorite = UserDefaults.standard.bool(forKey: viewModel.newsTitle)
            
            UserDefaults.standard.set(!isFavorite, forKey: viewModel.newsTitle)
            checkIfFavorite()
        }}
