//
//  MainLoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 30/03/2021.
//

import UIKit

class MainLoginViewController: UIViewController {

    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var enteraYourMobileLabel: UILabel!
    
    @IBOutlet weak var plusBox: UILabel!
    
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    
    static let PHONE_KEY :String = "phone"
    var loginViewModel :LoginViewModel!
    var apiKey : String?
    var mobilePhoneNum : String = ""
    var tableInfo : [TableInfoModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneView.layer.borderWidth = 1.0
        phoneView.layer.cornerRadius = 12
        phoneView.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.delegate = self
        countryCode.delegate = self
        
    
        // MARK: Binding :-
                
                loginViewModel = LoginViewModel()
                loginViewModel.bindLogingModel = {
                    (error:String? , data:[TableInfoModel]?) ->() in
                    
                    DispatchQueue.main.async {
                        if let error = error {
                           // alert
                            print(error)
                            
                            self.notFoundLabel.alpha = 1
                            
                        }
                        
                        
                        if let data = data {
                            
                            //Save Phone to UserDefault :-
                            self.saveToUserDefult(phone:self.mobilePhoneNum)
                            
                            
                            var vc = self.storyboard?.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
                            vc.tableInfoModel = data
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            
                        }
                        
                    }
                }
        
        
       
    }
    
    override func viewDidLayoutSubviews() {
     //Creates the bottom border
           let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)

        
        countryCode.layer.addBorder(edge: UIRectEdge.right, color: UIColor.lightGray, thickness: 1.0)
        

        }
    
    
    
    @IBAction func countryCodeChanged(_ sender: Any) {
   
        if(countryCode.text!.count > 3){
            
            countryCode.deleteBackward()
            
        }
        
    }
    
    
    // MARK:Functions :-
        
        func saveToUserDefult(phone:String) {
            
            let defaults = UserDefaults.standard
            defaults.set(phone, forKey: LoginViewController.PHONE_KEY)
            
            
        }
    
    



    
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        mobilePhoneNum = "00\(countryCode.text!)\(phoneTextField.text!)"
         print(mobilePhoneNum)
         if((phoneTextField.text!.isEmpty)){
             
             print("enter mobile")
         }
         else{
            if(LanguageOperation.checkLanguage() == .arabic){
                apiKey = "ar"
            }
            else{
                apiKey = nil
            }
           
             loginViewModel.login(phone: mobilePhoneNum, key: apiKey)
             phoneTextField.text = ""
             
         }
        
        
    }
    
}

extension MainLoginViewController : UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == phoneTextField){
            phoneTextField.text = ""
             phoneTextField.textAlignment = .center
        }
        if(textField == countryCode){
           
            textField.text = ""
            
        }
    }
}


