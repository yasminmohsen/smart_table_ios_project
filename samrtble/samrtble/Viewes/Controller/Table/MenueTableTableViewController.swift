//
//  MenueTableTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 01/04/2021.
//

import UIKit
import MOLH
class MenueTableTableViewController: UITableViewController {

  
    @IBOutlet weak var contactUs: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        contactUs.titleLabel?.textAlignment = .center
    }

    @IBAction func aboutAppBtn(_ sender: Any) {
    }
    
    
    @IBAction func contactUsBtn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "contactUsVc") as! ContactUsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func rateUsBtn(_ sender: Any) {
        var appId = "com.optimalsoft.samrtble"
        https://itunes.apple.com/us/app/urbanspoon/id284708449
        if let url = URL(string: "itms-apps://apple.com/app/\(appId)") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    
    @IBAction func languageBtn(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
         

         
         restartApplication()
        
        
    }
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        Alert.showAdvanceedAlert(title: "Alert", message: "Do you want to log out ?", viewRef: self) {
            UserDefaults.standard.set(nil, forKey: MainLoginViewController.PHONE_KEY)
            let launchScreen = UIStoryboard(name: "Main", bundle: nil)
            var vc = launchScreen.instantiateViewController(withIdentifier: "loginVc") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
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
