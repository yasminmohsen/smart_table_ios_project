//
//  LoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var phoneView: UIView!
    
    var loginViewModel :LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel = LoginViewModel()
        loginViewModel.bindLogingModel = {
            (error:String? , data:String?) ->() in
            
            DispatchQueue.main.async {
            if let error = error {
                
                print(error)
                
            }
        
            
            if let data = data {
                
                var vc = self.storyboard?.instantiateViewController(withIdentifier: "home")as! HomeViewController
                      
                self.navigationController?.pushViewController(vc, animated: true)
            
                
            }
            
            }
        }
        
        
    }
    

   
    @IBAction func loginBtn(_ sender: Any) {
        
        loginViewModel.login(phone: "00201017670053", key: nil)
        
        
    }
    
    
    
//    func updateView(result:String)  {
//
//        DispatchQueue.main.async {
//
//            if (result == "sucess"){
//
//                var vc = self.storyboard?.instantiateViewController(withIdentifier: "home")as! HomeViewController
//
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//
//            else{
//
//                print(result)
//            }
//
//        }
//
//
//
   // }
    
}
