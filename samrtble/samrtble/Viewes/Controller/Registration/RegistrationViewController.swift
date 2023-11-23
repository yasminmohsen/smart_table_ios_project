//
//  RegistrationViewController.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 21/10/2023.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerButton: GradientButton!
    @IBOutlet weak var balckButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userCode: String?
    var loginViewModel :LoginViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    init(userCode: String) {
        loginViewModel = LoginViewModel()
        self.userCode = userCode
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinding()
        setupUI()
    }
    
    private func viewModelBinding() {
        loginViewModel?.bindLogingModel = {
            (error:String? , result:Result?, netWorkError:String?) ->() in
            DispatchQueue.main.async { [weak self] in
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
        
        loginViewModel?
            .showErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in self?.showError(message: $0)})
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        userNameView.applyPrimaryTextFieldStyle()
        passwordView.applyPrimaryTextFieldStyle()
        emailView.applyPrimaryTextFieldStyle()
        passwordLabel.text = "Password".localized
        userNameLabel.text = "Username".localized
        emailLabel.text = "Email".localized
        balckButton.setTitle("Back".localized, for: .normal)
        registerButton.setTitle("Register".localized, for: .normal)
        titleLabel.text = "Teacher registration".localized
        
        userNameTextField.placeholder = "Enter your name".localized
        passwordTextField.placeholder = "Enter your password ...".localized
        emailTextField.placeholder = "Enter your email ...".localized
    }
    
    func onSucessUpdateView(){
        self.saveToUserDefult(phone: loginViewModel?.userCode ?? "")
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///Save To UserDefults :-
    func saveToUserDefult(phone:String) {
        let defaults = UserDefaults.standard
        defaults.set(phone, forKey: LoginViewController.PHONE_KEY)
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
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
    }
    
    @IBAction func didTapEyeButton(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .start)
        let password = passwordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        errorLabel.isHidden = true
        
        let validationEmptyCondition = !password.isEmpty && !email.isEmpty && !userName.isEmpty
        
       let validationCondition = isPasswordValid(password) && isEmailValid(email)
        
        if validationEmptyCondition  {
            if validationCondition {
                loginViewModel?.register(with: userCode ?? "", userName: userName, password: password, email: email)
            }
        } else {
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
            showError(message: "Please fill all fields".localized)
        }
    }
    
    private func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.errorLabel.text = message
            self.errorLabel.isHidden = false
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: self.activityIndicatore, status: .stop)
        }
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let condition =  password.count >= 8
        
        if condition == false {
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
            showError(message: "Password must be at least 8 characters".localized)
        }

        return condition
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let condition = emailPredicate.evaluate(with: email)
        
        if condition == false {
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
            showError(message: "Email is not correct".localized)
        }
        
        return condition
    }
    
    func isUserNameValid(_ userName: String) -> Bool {
        if userName.isEmpty {
            return false
        }
        return true
    }
}
