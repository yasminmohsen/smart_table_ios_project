//
//  ForgetPasswordViewController.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 21/10/2023.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    
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
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        Task {  [weak self] in
            guard let self else { return }
            do {
                let success = try await NetworkManager.forgetPassword(appService: .forgetPassword(email: emailTextField.text ?? ""))
                print("Registration Successful: \(success)")
    
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    Alert.showAdvanceedAlert(title: "Alert".localized, message: "Please check your email".localized, viewRef: self) {  [weak self] in
                        guard let self else { return }
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } catch(let error) {
                switch error {
                    
                default:
                    print("Unknown Error")
                }
            }
        }
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
