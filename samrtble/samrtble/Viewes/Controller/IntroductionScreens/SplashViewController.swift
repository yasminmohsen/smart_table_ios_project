//
//  SplashViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/03/2021.
//

import UIKit
import MOLH

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(MOLHLanguage.currentAppleLanguage())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            if let mobilePhone = UserDefaults.standard.string(forKey: LoginViewController.PHONE_KEY){
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let  vc = storyboard.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                
                if let checkValue = UserDefaults.standard.string(forKey: FirstScreenViewController.GO_LOGIN){
                    
                    let  vc = LoginViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    let  vc = self.storyboard?.instantiateViewController(withIdentifier: "firstVC")as! FirstScreenViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}
