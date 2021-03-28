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
        
        titleLabel.font = UIFont(name: CustomFonts.MyriadProBold.rawValue, size: 18)
        
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        descriotionLabel.font = UIFont(name: CustomFonts.MyriadPro.rawValue, size: 18)
        
        descriotionLabel.textColor = Colors.getColor(type: .customGreen)[0]
        
        
      
        pageControl.currentPageIndicatorTintColor = Colors.getColor(type: .customorange)[0]
   }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
