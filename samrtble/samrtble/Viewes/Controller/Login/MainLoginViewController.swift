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

        customUi()
    
        // MARK: Binding :-
                
                loginViewModel = LoginViewModel()
                loginViewModel.bindLogingModel = {
                    (error:String? , result:Result?, netWorkError:String?) ->() in
                    
                    DispatchQueue.main.async {[weak self] in
                        
                        guard let self = self else {return}
                        
                        
                        if let netWorkError = netWorkError {
                            self.onFiluer(error: nil, netWorkError: netWorkError)
                        }
                        
                        if let error = error {
                            self.onFiluer(error: error, netWorkError: nil)
                          
                        }
                        
                        
                        if let result = result {
                            
                            self.onSucessUpdateView()
                           
                            
                        }
                        
                    }
                }
    }
    
  
    override func viewDidLayoutSubviews() {
     //Creates the bottom border
           let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)

        }
    

    
    // MARK:Functions :-
    
    func customUi(){
        let lang = LanguageOperation.checkLanguage()
        switch lang {
        case .arabic:
            enteraYourMobileLabel.textAlignment = .right
            phoneTextField.textAlignment = .right
        default:
            enteraYourMobileLabel.textAlignment = .left
            phoneTextField.textAlignment = .left
        }
        
        phoneTextField.placeholder = "Enter Id".localized
        phoneTextField.setLeftPaddingPoints(10)
        phoneTextField.setRightPaddingPoints(10)
        
        phoneView.layer.borderWidth = 1.0
        phoneView.layer.cornerRadius = 12
        phoneView.layer.borderColor = UIColor.lightGray.cgColor
     //   phoneTextField.delegate = self
       // countryCode.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
    }
    
    ///Save To UserDefults :-
        func saveToUserDefult(phone:String) {
            
            let defaults = UserDefaults.standard
            defaults.set(phone, forKey: MainLoginViewController.PHONE_KEY)
            
            
        }
    

       

    
    // MARK: After Binding Functions :-
    
    func onSucessUpdateView(){
        
        self.saveToUserDefult(phone:self.mobilePhoneNum)
     
        
        var vc = self.storyboard?.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController

        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func onFiluer(error:String? ,netWorkError:String?){
        if let netWorkError = netWorkError {
            Alert.showSimpleAlert(title: "Alert", message: netWorkError, viewRef: self)
                        
        }
        
        if let error = error {
            if error == "Error!"{
                print(error)
                Alert.showSimpleAlert(title: "Alert", message: error, viewRef: self)
            }
            else{
                self.notFoundLabel.alpha = 1
                self.notFoundLabel.text = error
            }
           
           
          
            
        }
        
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
    }
    
    
    
   
    
    
    // MARK:Action Functions :-
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    @IBAction func loginBtn(_ sender: Any) {
        
        mobilePhoneNum = "\(phoneTextField.text!)"
         if((phoneTextField.text!.isEmpty)){
             
            Alert.showSimpleAlert(title: "Alert", message: "Enter user id", viewRef: self)
         }
        
         else{
    

            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .start)
            loginViewModel.fetchDataFromApi(phone: mobilePhoneNum)
             
         }
        
        
    }
    
}

   //*****************************************************************************************************//

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


