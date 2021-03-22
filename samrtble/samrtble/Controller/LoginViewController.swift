//
//  LoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var codeCountryTextField: UITextField!
    
    static let PHONE_KEY :String = "phone"
    var loginViewModel :LoginViewModel!
    var apiKey : String?
    var mobilePhoneNum : String = ""
    var tableInfo : [TableInfoModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
        
     
        cutsomUi()
        
// MARK: CheckUserDeafaults :-
        
       // CheckUserDeafaults()
        
        
// MARK: Binding :-
        
        loginViewModel = LoginViewModel()
        loginViewModel.bindLogingModel = {
            (error:String? , data:[TableInfoModel]?) ->() in
            
            DispatchQueue.main.async {
                if let error = error {
                   // alert
                    print(error)
                    
                }
                
                
                if let data = data {
                    
                    //Save Phone to UserDefault :-
                    self.saveToUserDefult(phone:self.mobilePhoneNum)
                    
                    var vc = self.storyboard?.instantiateViewController(withIdentifier: "home")as! HomeViewController
                    vc.tableInfoModel = data
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }
                
            }
        }
        
        
        
//        let preferredLanguage = NSLocale.preferredLanguages[0]
//
//
//         if preferredLanguage == "en" {print("hrllo")
//             
//         } else if preferredLanguage == "ar" {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//                UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
//        
//         }
//  
        
    }
    
    
    
    
    
    func cutsomUi(){
        
        CustomButton.customButtonWithShadow(button: loginBtn)
      
        
    }
    
    
// MARK:ButtonsAction :-
    @IBAction func loginBtn(_ sender: Any) {
        mobilePhoneNum = phoneTextField.text!
        if((phoneTextField.text!.isEmpty)){
            
            print("enter mobile")
        }
        else{
          
            loginViewModel.login(phone: mobilePhoneNum, key: apiKey)
            phoneTextField.text = ""
            
        }
       
    }
    
    
    @IBAction func arabicBtn(_ sender: UIBarButtonItem) {
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            if let vc = storyboard?.instantiateViewController(withIdentifier: "login") {
                UIApplication.shared.keyWindow?.rootViewController = vc
            }
        
        
    }
    
    
// MARK:Functions :-
    
    func saveToUserDefult(phone:String) {
        
        let defaults = UserDefaults.standard
        defaults.set(phone, forKey: LoginViewController.PHONE_KEY)
        
        
    }
    
    
    func CheckUserDeafaults()  {
        let defaults = UserDefaults.standard
        if(defaults.string(forKey: LoginViewController.PHONE_KEY) != nil){
            var vc = self.storyboard?.instantiateViewController(withIdentifier: "home")as! HomeViewController
            if let loginViewModelData = loginViewModel.data{
                vc.tableInfoModel = loginViewModelData
           
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    
    }
    
    
    
    
}


extension LoginViewController :UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == phoneTextField ){
            phoneTextField.text = ""
             phoneTextField.textAlignment = .left
            
        }
       
      
        }
        
        
    
    
    
   
    
    
    
    
    
}
