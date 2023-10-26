//
//  LoginViewController.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 25/10/2023.
//
import UIKit
import Combine

enum LoginType {
    case withId
    case withUserName
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: GradientButton!
    @IBOutlet weak var userNameView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var withIDButton: UIButton!
    
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var withUserNameButton: UIButton!
    
    @IBOutlet weak var passwordStakView: UIStackView!
    static let PHONE_KEY :String = "phone"
    var loginViewModel = LoginViewModel()
    var userCode : String = ""
    var tableInfo : [TableInfoModel]!
    var loginType = LoginType.withId
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        customUi()
        viewModelBinding()
    }
    
    private func setupUI() {
        setupRadioButtons()
        setupUserNameTextField()
        
        passwordTitleLabel.text = "Password".localized
        passwordTextField.placeholder = "Enter your password ...".localized
        
        loginTitleLabel.text = "Select login type".localized
        forgetPasswordButton.setTitle("FORGOT PASSWORD".localized, for: .normal)
        
        titleView.layer.cornerRadius = 8
        
        userNameView.applyPrimaryTextFieldStyle()
        passwordView.applyPrimaryTextFieldStyle()
    }
    
    private func setupUserNameTextField() {
        loginButton.setTitle("Login".localized, for: .normal)
        userNameLabel.text =  loginType == .withId ? "Login ID".localized : "Username".localized
        userNameTextField.placeholder =  loginType == .withId ? "Enter Id".localized : "Enter your name".localized
    }
    
    private func viewModelBinding() {
        loginViewModel
            .unRegisteredUserPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.navigateToRegisterScreen()})
            .store(in: &cancellables)
        
        loginViewModel
            .showErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.showError(message: $0)})
            .store(in: &cancellables)
        
        loginViewModel.bindLogingModel = { [weak self] (error:String? , result:Result?, netWorkError:String?) ->()  in
            
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
    
    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
    }
    
    private func navigateToRegisterScreen() {
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
        let registerVC = RegistrationViewController(userCode: loginViewModel.userCode ?? "")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func customUi(){
        //        let lang = LanguageOperation.checkLanguage()
        //        switch lang {
        //        case .arabic:
        //            enteraYourMobileLabel.textAlignment = .right
        //            phoneTextField.textAlignment = .right
        //        default:
        //            enteraYourMobileLabel.textAlignment = .left
        //            phoneTextField.textAlignment = .left
        //        }
        
        
        //        phoneTextField.setLeftPaddingPoints(10)
        //        phoneTextField.setRightPaddingPoints(10)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
    }
    
    private func setupRadioButtons() {
        // deselected state
        withIDButton.setTitleColor(.darkGrey, for: .normal)
        withIDButton.setImage(UIImage(named: "unselected-radio"), for: .normal)
        
        withUserNameButton.setTitleColor(.darkGrey, for: .normal)
        withUserNameButton.setImage(UIImage(named: "unselected-radio"), for: .normal)
        
        
        // selected state
        withIDButton.setTitleColor(.primaryGreen, for: .selected)
        withIDButton.setImage(UIImage(named: "selected-radio"), for: .selected)
        
        withUserNameButton.setTitleColor(.primaryGreen, for: .selected)
        withUserNameButton.setImage(UIImage(named: "selected-radio"), for: .selected)
        
        withIDButton.setTitle("With ID".localized, for: .normal)
        withUserNameButton.setTitle("With username".localized, for: .normal)
        
        
        let spacing: CGFloat = 7
        withIDButton.configuration?.imagePadding = spacing
        withUserNameButton.configuration?.imagePadding = spacing
        
        // initailization
        withIDButton.isSelected = true
        
        
    }
    
    ///Save To UserDefults :-
    func saveToUserDefult(userCode: String) {
        
        let defaults = UserDefaults.standard
        defaults.set(userCode, forKey: LoginViewController.PHONE_KEY)
        
    }
    
    
    // MARK: After Binding Functions :-
    
    func onSucessUpdateView(){
        
        self.saveToUserDefult(userCode: self.userCode)
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var vc = storyboard.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
        
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
                self.errorLabel.alpha = 1
                self.errorLabel.text = error
            }
        }
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        errorLabel.isHidden = true
        userCode = "\(userNameTextField.text ?? "")"
        if((userNameTextField.text!.isEmpty)){
            Alert.showSimpleAlert(title: "Alert", message: "Enter user id", viewRef: self)
        } else {
            
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .start)
            if loginType == .withUserName {
                loginViewModel.login(with: userNameTextField.text ?? "", password: passwordTextField.text ?? "")
            } else {  // .withId
                loginViewModel.userCode = userNameTextField.text ?? ""
                loginViewModel.register(with: userNameTextField.text ?? "")
            }
        }
        
    }
    
    @IBAction func didTapForgetPassword(_ sender: Any) {
        errorLabel.isHidden = true
        let forgetPasswordVC = ForgetPasswordViewController()
        navigationController?.pushViewController(forgetPasswordVC, animated: true)
    }
    
    @IBAction func didTapWithIdButton(_ sender: Any) {
        withIDButton.isSelected = true
        withUserNameButton.isSelected = false
        loginType = .withId
        setupUserNameTextField()
        passwordStakView.isHidden = true
        userNameTextField.text = ""
        errorLabel.isHidden = true
    }
    
    @IBAction func didTapWithUserNameButton(_ sender: Any) {
        withUserNameButton.isSelected = true
        withIDButton.isSelected = false
        loginType = .withUserName
        setupUserNameTextField()
        passwordStakView.isHidden = false
        passwordTextField.text = ""
        userNameTextField.text = ""
        errorLabel.isHidden = true
    }
    
    @IBAction func didTapEyeButton(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
    }
}
