//
//  HomeNewCell.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 8.09.2023.
//

import UIKit
import SDWebImage

class HomeNewCell: UITableViewCell {
    
    public static var identifier: String {
        get {
            return "HomeNewCell"
        }
    }
    
    public static func register() -> UINib {
        UINib(nibName: "HomeNewCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var newTitle: UILabel!
    
    @IBOutlet weak var newImageView: UIImageView!
    
    @IBOutlet weak var newDescription: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    //    backView.addBorder(color: .label, width: 1)
    
        
      //  newImageView.layer.cornerRadius = 5
    }
    
    func setupCell(homeViewModel: NewTableCellModel) {
        self.newTitle.text = homeViewModel.title
        self.newDescription.text = homeViewModel.description
        self.newImageView.sd_setImage(with: homeViewModel.imageUrl, completed: nil)  // SDWebImage kütüphanesi burada kullanılıyor
    }
    
}
