//
//  CustomButton.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 22/03/2021.
//

import Foundation
import UIKit
class CustomButton {
    
    
    static func customButtonWithShadow ( button:UIButton){
        
        
       
            button.layer.shadowColor =  UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height:2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 4.0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 12.0
            
            
            
        
    
        
        
        
    }
    
    
    
    static func customBarButton (btnBack :UIButton , title:String){
        
        btnBack.setTitle("\(title)", for: .normal)
        btnBack.setTitleColor(UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0), for: .normal)
        btnBack.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btnBack.layer.shadowOffset = CGSize(width: 0.0, height:2.0)
        btnBack.layer.shadowColor = UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0).cgColor
        btnBack.layer.shadowOpacity = 1.0
        btnBack.layer.shadowRadius = 10.0
        btnBack.layer.masksToBounds = false
        btnBack.layer.borderWidth = 0.2
        btnBack.layer.borderColor = UIColor(red: 180/255, green: 147/255, blue: 108/255, alpha: 1.0).cgColor

    }
    
    
    
   
    
    
}


