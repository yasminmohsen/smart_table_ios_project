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
        
        titleLabel.font = UIFont(name: CustomFonts.MyriadProBold.rawValue, size: 18)
        
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        descriotionLabel.font = UIFont(name: CustomFonts.MyriadPro.rawValue, size: 18)
        
        descriotionLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        
      
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
        
    
      
    }
    

}
