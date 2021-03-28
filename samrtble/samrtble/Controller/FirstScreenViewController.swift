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
        
        titleLabel.font = UIFont(name: CustomFonts.MyriadProBold.rawValue, size: 18)
        
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        descriotionLabel.font = UIFont(name: CustomFonts.MyriadPro.rawValue, size: 18)
        
        descriotionLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        
      
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
        
        
        
        
    }
  

        
    
    

}

