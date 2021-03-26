//
//  LoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import UIKit
import MOLH

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var plusBoxView: UILabel!
    
    @IBOutlet weak var codeCountryTextField: UITextField!
    
    static let PHONE_KEY :String = "phone"
    var loginViewModel :LoginViewModel!
    var apiKey : String?
    var mobilePhoneNum : String = ""
    var tableInfo : [TableInfoModel]!
    
    
    
    lazy var righttBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
     
        CustomButton.customBarButton(btnBack: btnBack, title: "English".localized)
        btnBack.addTarget(self, action: #selector(arabicBtn(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()
    
    
    @IBOutlet weak var stackViewPhone: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        phoneView.semanticContentAttribute = .forceRightToLeft
       stackViewPhone.semanticContentAttribute = .forceLeftToRight
        
       /* plusBoxView.layer.addBorder(edge: UIRectEdge.top, color: UIColor.brown, thickness: 1.0)
       plusBoxView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.brown, thickness: 1.0)
        plusBoxView.layer.addBorder(edge: UIRectEdge.left, color: UIColor.brown, thickness: 1.0)
//
       codeCountryTextField.layer.addBorder(edge: UIRectEdge.top, color: UIColor.brown, thickness: 1.0)
        codeCountryTextField.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.brown, thickness: 1.0)
        
      //  phoneTextField.delegate = self
        codeCountryTextField.delegate = self*/
        
     
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
        
 
//  
        
    }
    
    
    
    
    
    func cutsomUi(){
        
        CustomButton.customButtonWithShadow(button: loginBtn)
        
       
    
        
        self.navigationItem.setRightBarButtonItems(self.righttBarItem, animated: true)
      
        phoneTextField.layer.borderWidth = 1.0
        phoneTextField.layer.borderColor = UIColor.brown.cgColor
        phoneTextField.delegate = self
        codeCountryTextField.delegate = self
    }
    
    
// MARK:ButtonsAction :-
    @IBAction func loginBtn(_ sender: Any) {
        print("\(codeCountryTextField.text!)\(phoneTextField.text!)")
       // mobilePhoneNum = "00\(codeCountryTextField.text!)\(phoneTextField.text!)"
        mobilePhoneNum = "00201017670053"
        print(mobilePhoneNum)
        if((phoneTextField.text!.isEmpty)){
            
            print("enter mobile")
        }
        else{
            
          
            loginViewModel.login(phone: mobilePhoneNum, key: apiKey)
            phoneTextField.text = ""
            
        }
       
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
//        print(MOLHLanguage.currentAppleLanguage())

    }
    
   @objc func arabicBtn(_ sender: UIBarButtonItem) {
        
       MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        

        
        restartApplication()
        
    }
    
    @IBAction func countryCodeChange(_ sender: Any) {
        
        
        print("hhh")
        if(codeCountryTextField.text!.count > 3){
            
            codeCountryTextField.deleteBackward()
            
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
        
        if(textField == phoneTextField){
            phoneTextField.text = ""
             phoneTextField.textAlignment = .center
        }
        if(textField == codeCountryTextField){
           
            textField.text = ""
            
        }
    }
      
   

    override func viewDidLayoutSubviews() {
     //Creates the bottom border
           let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)

            plusBoxView.layer.addBorder(edge: UIRectEdge.top, color: UIColor.brown, thickness: 1.0)
            plusBoxView.layer.addBorder(edge: UIRectEdge.left, color: UIColor.brown, thickness: 1.0)
            
             plusBoxView.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.brown, thickness: 1.0)
            
      
             codeCountryTextField.layer.addBorder(edge: UIRectEdge.top, color: UIColor.brown, thickness: 1.0)
              codeCountryTextField.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.brown, thickness: 1.0)
        
        
        
        
        

        }
    
    
    
    
    
    func restartApplication () {
        var tableViewController = self.storyboard!.instantiateViewController(withIdentifier: "splashScreen") as! SplashViewController

        let navCtrl = UINavigationController(rootViewController:tableViewController)
        //
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
            else {
                return
        }
 

        navCtrl.setNavigationBarHidden(false, animated: true)
        navCtrl.navigationBar.prefersLargeTitles = true
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = navCtrl
        })

    }
    
    
    
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width , height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
            
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}

