//
//  ContactUsViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 06/04/2021.
//

import UIKit
import MessageUI
class ContactUsViewController: UIViewController ,UITextViewDelegate,UITextFieldDelegate{
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var sendBtn: GradientButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var contentTextArea: UITextView!
    var keyBoardFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.alpha = 0
        registerForKeyboardNotifications()
        CustomDesignView.customTextView(view: userNameTextField)
        CustomDesignView.customTextView(view: contentTextArea)
        
        let lang = LanguageOperation.checkLanguage()
        if(lang == .arabic){
            contentTextArea.textAlignment = .right
            backBtn.setImage(UIImage(named: "left-arrow ")?.flippedImage(), for: .normal)
        }
        else{
            contentTextArea.textAlignment = .left
            backBtn.setImage(UIImage(named: "left-arrow "), for: .normal)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = ""
        
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }

    // MARK: KeyBoardDismiss :-
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        textView.text = ""
        textView.textColor = UIColor.black
        
    }
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        
        sendEmail()
    }
    
    
    
    
    
    // MARK: KeyBoardNotificationForTextField :-
    
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWasShown(_:)),
                                               name:UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
          
    }
     
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
              let keyboardFrameValue =
                info[UIResponder.keyboardFrameBeginUserInfoKey]
                as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
                                         bottom: keyboardSize.height, right: 0.0)
        
        
        
        
        self.view.frame.origin.y =  -200
        navigationController?.navigationBar.alpha = 1
    }
    
    
     
    @objc func keyboardWillBeHidden(_ notification:
                                        NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        self.view.frame.origin.y = 0
        navigationController?.navigationBar.alpha = 0
        
    }
    
    
    
    
    
}


// MARK: Email Functions :-

extension ContactUsViewController :MFMailComposeViewControllerDelegate {
    
    func sendEmail(){
        
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        if (contentTextArea.text.count > 0 && userNameTextField.text!.count > 0 ) {
            mailComposer.setToRecipients(["info@smartble.com"])
            mailComposer.setSubject("Clients issue")
            mailComposer.setMessageBody("\(contentTextArea.text!)\n ....\n\(userNameTextField.text!)" ,isHTML: false)
            present(mailComposer, animated: true, completion: nil)
        }
        else{
            
            Alert.showSimpleAlert(title: "Invalid email", message: "Fill empty fields", viewRef: self)
        }
        
        
        
    }
    
    
    
}

