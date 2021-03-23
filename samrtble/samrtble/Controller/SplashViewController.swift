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
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        }
         
    }
    @IBOutlet weak var btn: UIBarButtonItem!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
