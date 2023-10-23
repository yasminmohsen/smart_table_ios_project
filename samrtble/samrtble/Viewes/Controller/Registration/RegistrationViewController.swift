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
    
    init() {
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
        
    }
}
