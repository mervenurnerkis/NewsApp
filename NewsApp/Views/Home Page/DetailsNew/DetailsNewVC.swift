//
//  DetailsNewVC.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 8.09.2023.
//

import UIKit
import SDWebImage

class DetailsNewVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
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
    }

    func configView() {
        self.title = "News Details"
        newsTitle.text = viewModel.newsTitle
        newsDescription.text = viewModel.newsDescription
        imageView.sd_setImage(with: viewModel.newsImage, completed: nil)  // SDWebImage kütüphanesi burada kullanılıyor
    }


}
