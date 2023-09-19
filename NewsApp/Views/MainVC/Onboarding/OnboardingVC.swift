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
            OnboardingSlide(title: "WELCOME", description: "You can follow the latest news.",image: UIImage(named: "TheNews")!),
            OnboardingSlide(title: "FOLLOW THE AGENDA", description: "lYou can keep abreast of the world's agenda and access news according to your interests." , image: UIImage(named: "TheNews")!),
            OnboardingSlide(title: "SAVE ARTICLES FOR LATER", description: "Tap the bookmark to read what you want,when you want." , image: UIImage(named: "TheNews")!)
        ]
        if UserDefaults.standard.bool(forKey: "ISLOGGEDIN") == true {
            let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
            let webVC = storyboard.instantiateViewController(withIdentifier: "TabbarVC") 
            self.navigationController?.pushViewController(webVC, animated: false)
            
           /* UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
            let main = UIStoryboard(name: "HomeVC", bundle: nil)
            let home = main.instantiateViewController(withIdentifier: "TabbarVC")
            self.present(home, animated: true, completion: nil) */
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
          /*  let controller = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            
            present(controller, animated: true, completion: nil)*/
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
        let currentPage = Int(scrollView.contentOffset.x / width)

    }
}
