//
//  MainLoginViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 30/03/2021.
//

import UIKit

class MainLoginViewController: UIViewController {

    
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var enteraYourMobileLabel: UILabel!
    
    @IBOutlet weak var plusBox: UILabel!
    
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneView.layer.borderWidth = 1.0
        phoneView.layer.cornerRadius = 12
        phoneView.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.delegate = self
        countryCode.delegate = self
        
       
    }
    
    override func viewDidLayoutSubviews() {
     //Creates the bottom border
           let borderBottom = CALayer()
            let borderWidth = CGFloat(1.0)

//        plusBox.layer.addBorder(edge: UIRectEdge.top, color: UIColor.lightGray, thickness: 1.0)
//        plusBox.layer.addBorder(edge: UIRectEdge.left, color: UIColor.lightGray, thickness: 1.0)
//            
//        plusBox.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.lightGray, thickness: 1.0)
//            
//      
//        countryCode.layer.addBorder(edge: UIRectEdge.top, color: UIColor.lightGray, thickness: 1.0)
//        countryCode.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.lightGray, thickness: 1.0)
        
        countryCode.layer.addBorder(edge: UIRectEdge.right, color: UIColor.lightGray, thickness: 1.0)
        
        
        
        

        }
    
    

}

extension MainLoginViewController : UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == phoneTextField){
            phoneTextField.text = ""
             phoneTextField.textAlignment = .center
        }
        if(textField == countryCode){
           
            textField.text = ""
            
        }
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
