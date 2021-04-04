//
//  FirstScreenViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/03/2021.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriotionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
//    titleLabel.font = UIFont(name: CustomFonts.MyriadProBold.rawValue, size: 18)
//        
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
//        
//        descriotionLabel.font = UIFont(name: CustomFonts.MyriadPro.rawValue, size: 18)
        
//        descriotionLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        
        
      
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        
        leftSwipe.direction = .left
            self.view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        
        rightSwipe.direction = .right
            self.view.addGestureRecognizer(rightSwipe)
        CheckUserDeafaults()
        
    }
  

        
    
    func CheckUserDeafaults()  {
        let defaults = UserDefaults.standard
        if(defaults.string(forKey: MainLoginViewController.PHONE_KEY) != nil){
            var vc = self.storyboard?.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController 
            
               // vc.tableInfoModel = loginViewModelData
           
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        
        
        
    }
    
    }

    
    
    @objc func swipe(gesture :UISwipeGestureRecognizer) {
        let lang = LanguageOperation.checkLanguage()
        let vc = storyboard?.instantiateViewController(identifier: "secondVc") as! SecondScreenViewController
        switch gesture.direction {
        case .right:
            
            switch lang {
            case .arabic:
                self.navigationController?.pushViewController(vc, animated: true)
        
            default:
                break
            }
            
            
        case .left:
            
            switch lang {
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

