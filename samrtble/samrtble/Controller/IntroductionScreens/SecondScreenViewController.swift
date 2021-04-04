//
//  SecondScreenViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 28/03/2021.
//

import UIKit

class SecondScreenViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriotionLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
      
       titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
/*
       descriotionLabel.font = UIFont(name: CustomFonts.MyriadPro.rawValue, size: 18)
        titleLabel.font = UIFont(name: CustomFonts.MyriadProBold.rawValue, size: 18)
        */
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        
        leftSwipe.direction = .left
            self.view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        
        rightSwipe.direction = .right
            self.view.addGestureRecognizer(rightSwipe)
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
   }
    
    @objc func swipe(gesture :UISwipeGestureRecognizer) {
        let lang = LanguageOperation.checkLanguage()
        let vc = storyboard?.instantiateViewController(identifier: "thirdVc") as! ThirdScreenViewController
        switch gesture.direction {
        case .right:
            
            switch lang {
            case .arabic:
                self.navigationController?.pushViewController(vc, animated: true)
            case .english :
                
                self.navigationController?.popViewController(animated: true)
            
            default:
                break
            }
            
            
        case .left:
            
            switch lang {
            
            case .arabic:
                self.navigationController?.popViewController(animated: true)
            
            case .english:
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
            
            
            
            
        default:
            break
        }
        
        
        
        
       
        
        
        
    }
    
    

}
