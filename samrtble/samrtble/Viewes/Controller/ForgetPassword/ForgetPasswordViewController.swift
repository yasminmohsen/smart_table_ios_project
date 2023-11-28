//
//  ForgetPasswordViewController.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 21/10/2023.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sendButton: GradientButton!
    @IBOutlet weak var errorLabel: UILabel!
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        emailView.applyPrimaryTextFieldStyle()
        emailTextField.placeholder = "Enter your email ...".localized
        backButton.setTitle("Back".localized, for: .normal)
        sendButton.setTitle("Send".localized, for: .normal)
        titleLabel.text = "Restore your password".localized
        subtitleLabel.text = "Enter your email and a password recovery link will be delivered directly to your inbox".localized
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .start)
        errorLabel.isHidden = true
        if isEmailValid(emailTextField.text ?? "") {
            Task {  [weak self] in
                guard let self else { return }
                do {
                    let success = try await NetworkManager.forgetPassword(appService: .forgetPassword(email: emailTextField.text ?? ""))
                    print("Registration Successful: \(success)")
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: self.activityIndicatore, status: .stop)
                        Alert.showSimpleConfirmationAlert(title: "Alert".localized, message: "Please check your email".localized, viewRef: self) {  [weak self] in
                            guard let self else { return }
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } catch(let error) {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: self.activityIndicatore, status: .stop)
                        self.errorLabel.isHidden = false
                        switch error {
                        case NetworkError.withMessage(let error):
                            self.errorLabel.text = error
                        default:
                            self.errorLabel.text = "UnKnown Error".localized
                        }
                    }
                }
            }
        } else {
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndicatore, status: .stop)
            errorLabel.isHidden = false
            errorLabel.text = "Please valid email".localized
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
