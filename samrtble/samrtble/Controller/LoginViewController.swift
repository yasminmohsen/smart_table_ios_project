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
    static let PHONE_KEY :String = "phone"
    var loginViewModel :LoginViewModel!
    var apiKey : String?
    var mobilePhoneNum : String = ""
    var tableInfo : [TableInfoModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
     
        
        
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
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }
                
            }
        }
  
        
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
        phoneTextField.text = ""
        phoneTextField.textAlignment = .left
    }
    
    
    func cutsomUi(){
        
        //custom ui
        
    }
    
    
    
    
}
