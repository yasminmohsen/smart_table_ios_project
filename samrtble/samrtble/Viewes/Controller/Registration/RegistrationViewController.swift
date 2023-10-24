//
//  RegistrationViewController.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 21/10/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var userNameErrorLable: UILabel!
    @IBOutlet weak var emailErrorLable: UILabel!
    @IBOutlet weak var passwordErrorLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userCode: String?
    
    init(userCode: String) {
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
        setupUI()
    }
    
    private func setupUI() {
        userNameView.applyPrimaryTextFieldStyle()
        passwordView.applyPrimaryTextFieldStyle()
        emailView.applyPrimaryTextFieldStyle()
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        let password = passwordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let userName = userNameTextField.text ?? ""
        
        let validationCondition =  isPasswordValid(password) && isEmailValid(email) && isUserNameValid(userName)
        if validationCondition {
            register(password: password, email: email, userName: userName)
        }
    }
    
    private func register(password: String, email: String, userName: String) {
            Task { [weak self] in
                guard let self else { return }
                do {
                    let isSuccess =  try await NetworkManager.register(appService: .register(user: User(code: self.userCode ?? "", userName: userName, password: password, email: email)))
                    
                    if isSuccess {
                        
                    }
                    
                } catch NetworkError.notRegisteredBefore(let error) {
                    
                } catch NetworkError.registeredBefore(let error) {
                    
                }  catch {
                    print(error)
                }
            }
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        if password.isEmpty {
            passwordErrorLable.isHidden = false
            passwordErrorLable.text = "This field can't be empty".localized
            return false
        }
        let passwordRegex = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isEmailValid(_ email: String) -> Bool {
        if email.isEmpty {
            emailErrorLable.isHidden = false
            emailErrorLable.text = "This field can't be empty".localized
            return false
        }
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isUserNameValid(_ userName: String) -> Bool {
        if userName.isEmpty {
            userNameErrorLable.isHidden = false
            userNameErrorLable.text = "This field can't be empty".localized
            return false
        }
        return true
    }
}
