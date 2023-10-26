//
//  ThirdScreenViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 28/03/2021.
//

import UIKit

class ThirdScreenViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var descriotionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.layer.cornerRadius = 12
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        CustomDesignView.customPageController(pageControl)
        
    }
    
    @objc func swipe(gesture :UISwipeGestureRecognizer) {
        let lang = LanguageOperation.checkLanguage()
        let vc = storyboard?.instantiateViewController(identifier: "thirdVc") as! ThirdScreenViewController
        switch gesture.direction {
        case .right:
            switch lang {
            case .english :
                
                self.navigationController?.popViewController(animated: true)
                
            default:
                break
            }
        case .left:
            switch lang {
            case .arabic:
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        default:
            break
        }
    }
    @IBAction func start(_ sender: Any) {
        
        let defults = UserDefaults.standard
        defults.setValue("goLogin", forKey: FirstScreenViewController.GO_LOGIN)
        let  vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
