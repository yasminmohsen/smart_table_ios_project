//
//  AboutAppViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 07/04/2021.
//

import UIKit

class AboutAppViewController: UIViewController {
    @IBOutlet weak var aboutApplabel: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutApplabel.text = "About App".localized
      let lang =   LanguageOperation.checkLanguage()
        
        switch lang {
        case .arabic:
    
            backBtn.setImage(UIImage(named: "left-arrow ")?.flippedImage(), for: .normal)
            webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.smartble.net/about-app/ar/")! as URL) as URLRequest)
            
            
        default:
            backBtn.setImage(UIImage(named: "left-arrow "), for: .normal)
            webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.smartble.net/about-app/en/")! as URL) as URLRequest)
            
        }
        
        
        
    }
    

 

}
