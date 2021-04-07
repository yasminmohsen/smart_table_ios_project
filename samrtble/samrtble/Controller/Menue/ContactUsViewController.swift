//
//  ContactUsViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 06/04/2021.
//

import UIKit
import MessageUI
class ContactUsViewController: UIViewController ,UITextViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var contentTextArea: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CustomDesignView.customTextView(view: userNameTextField)
        CustomDesignView.customTextView(view: contentTextArea)
        CustomDesignView.customTextView(view: emailTextField)
         
        registerForKeyboardNotifications()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
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
            
            scrollView.contentInset = contentInsets
            
            scrollView.scrollIndicatorInsets = contentInsets
        }
     
        @objc func keyboardWillBeHidden(_ notification:
           NSNotification) {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
   
}
       
}


extension ContactUsViewController :MFMailComposeViewControllerDelegate {
    
    func sendEmail(){
        
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self

        if (contentTextArea.text.count > 0 && emailTextField.text!.count > 0 ) {
            mailComposer.setToRecipients([emailTextField.text!])
            mailComposer.setSubject("Clients issue")
            mailComposer.setMessageBody(contentTextArea.text, isHTML: false)
            present(mailComposer, animated: true, completion: nil)
        }
        else{
            
            Alert.showSimpleAlert(title: "Invalid email", message: "Fill empty fields", viewRef: self)
        }
      

        
    }
    
    
    
}

