//
//  MainLoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 30/03/2021.
//

import UIKit

class MainLoginViewController: UIViewController {

    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var enteraYourMobileLabel: UILabel!
    
    @IBOutlet weak var plusBox: UILabel!
    
   // @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var notFoundLabel: UILabel!

    static let PHONE_KEY :String = "phone"
    var loginViewModel :LoginViewModel!
    var mobilePhoneNum : String = ""
    var tableInfo : [TableInfoModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lang = LanguageOperation.checkLanguage()
        switch lang {
        case .arabic:
            enteraYourMobileLabel.textAlignment = .right
        default:
            enteraYourMobileLabel.textAlignment = .left
        }
        
        
        phoneView.layer.borderWidth = 1.0
        phoneView.layer.cornerRadius = 12
        phoneView.layer.borderColor = UIColor.lightGray.cgColor
     //   phoneTextField.delegate = self
       // countryCode.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    
        // MARK: Binding :-
                
                loginViewModel = LoginViewModel()
                loginViewModel.bindLogingModel = {
                    (error:String? , data:[TableInfoModel]?) ->() in
                    
                    DispatchQueue.main.async {[weak self] in
                        
                        guard let self = self else {return}
                        if let error = error {
                           // alert
                            
                            if error == "Error!"{
                                print(error)
                                Alert.showSimpleAlert(title: "Alert", message: error, viewRef: self)
                            }
                            else{
                                self.notFoundLabel.alpha = 1
                                self.notFoundLabel.text = error
                            }
                           
                           
                            self.activityIndecator.stopAnimating()
                            self.activityIndecator.alpha = 0
                            
                        }
                        
                        
                        if let data = data {
                            
                            //Save Phone to UserDefault :-
                            self.saveToUserDefult(phone:self.mobilePhoneNum)
                         
                            
                            var vc = self.storyboard?.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
                            vc.tableInfoModel = data
                            
                            
                            self.activityIndecator.stopAnimating()
                            self.activityIndecator.alpha = 0
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                            
                        }
                        
                    }
                }
        
        
       
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLayoutSubviews() {
     //Creates the bottom border
           let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)

        }
    

    
    // MARK:Functions :-
        
        func saveToUserDefult(phone:String) {
            
            let defaults = UserDefaults.standard
            defaults.set(phone, forKey: MainLoginViewController.PHONE_KEY)
            
            
        }
    

    @IBAction func loginBtn(_ sender: Any) {
        
        mobilePhoneNum = "\(phoneTextField.text!)"
         if((phoneTextField.text!.isEmpty)){
             
            Alert.showSimpleAlert(title: "Alert", message: "Enter user name", viewRef: self)
         }
        
         else{
    
            activityIndecator.startAnimating()
            activityIndecator.alpha = 1
            loginViewModel.fetchDataFromApi(phone: mobilePhoneNum)
           //loginViewModel.fetchData(phone: mobilePhoneNum)
             
         }
        
        
    }
    
}

//extension MainLoginViewController : UITextFieldDelegate{
//
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if(textField == phoneTextField){
//            phoneTextField.text = ""
//             phoneTextField.textAlignment = .center
//        }
//        if(textField == countryCode){
//
//            textField.text = ""
//
//        }
//    }
//
//
//}


