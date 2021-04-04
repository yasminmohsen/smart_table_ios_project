//
//  MenueTableTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 01/04/2021.
//

import UIKit
import MOLH
class MenueTableTableViewController: UITableViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func aboutAppBtn(_ sender: Any) {
    }
    
    
    @IBAction func contactUsBtn(_ sender: Any) {
    }
    
    
    
    @IBAction func rateUsBtn(_ sender: Any) {
    }
    
    
    
    
    @IBAction func languageBtn(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
         

         
         restartApplication()
        
        
    }
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        UserDefaults.standard.setValue(nil, forKey: MainLoginViewController.PHONE_KEY)
        
        let launchScreen = UIStoryboard(name: "Main", bundle: nil)
        var tableViewController = launchScreen.instantiateViewController(withIdentifier: "splashScreen") as! SplashViewController
        
        
    }
    
    
    
    
    
    func restartApplication () {
     
        let launchScreen = UIStoryboard(name: "Main", bundle: nil)
        var tableViewController = launchScreen.instantiateViewController(withIdentifier: "splashScreen") as! SplashViewController

        let navCtrl = UINavigationController(rootViewController:tableViewController)
        //
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
        }
 
        navCtrl.setNavigationBarHidden(true, animated: true)
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = navCtrl
        })

    }
    
    
    
}
