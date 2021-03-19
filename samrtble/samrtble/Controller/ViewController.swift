//
//  ViewController.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradient = CAGradientLayer()
        
        
        
        
        let yourColor : UIColor = UIColor( red: 0.180, green: 0.147, blue:0.108, alpha: 1.0 )
        phoneView.layer.masksToBounds = true
        phoneView.layer.borderColor = yourColor.cgColor
        phoneView.layer.borderWidth = 1.0
        phoneTextField.layer.borderWidth = 1.0
        phoneTextField.layer.borderColor = yourColor.cgColor
        phoneTextField.layer.backgroundColor = UIColor.white.cgColor
        
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.layoutIfNeeded()

    
    }

    @IBAction func loginBtn(_ sender: Any) {
        
        
        var vc = storyboard?.instantiateViewController(withIdentifier: "home")as! HomeViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}

