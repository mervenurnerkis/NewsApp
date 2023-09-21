//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Merve Nur Nerkis on 6.09.2023.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        slides = [
            OnboardingSlide(title: Constants.welcome, description: Constants.welcomeDescription,image: UIImage(named: Constants.theNews)!),
            OnboardingSlide(title: Constants.follow, description: Constants.followDescription,image: UIImage(named: Constants.theNews)!),
            OnboardingSlide(title: Constants.save, description: Constants.saveDescription,image: UIImage(named: Constants.theNews)!)

        ]
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            UserDefaults.standard.set(true, forKey: "isloggedin")
            
            let storyboard = UIStoryboard(name: "LoginVC", bundle: nil)
            if let webVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                self.navigationController?.pushViewController(webVC, animated: true)
            }
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        _ = Int(scrollView.contentOffset.x / width)

    }
}
