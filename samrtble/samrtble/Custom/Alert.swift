//
//  Alert.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 07/04/2021.
//

import Foundation
import UIKit
struct Alert {
    static func showSimpleAlert(title: String,message: String, viewRef: UIViewController){
        let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.cancel, handler: nil))
        viewRef.present(alert, animated: true, completion: nil)
    }
    
    static func showAdvanceedAlert(title: String,message: String, viewRef: UIViewController, actionClosure:@escaping()->Void) {
        
        let advancedAlert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: UIAlertController.Style.alert)
        advancedAlert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {
            action in
            
            actionClosure()
            
        }))
        
        advancedAlert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        
        viewRef.present(advancedAlert, animated: true, completion: nil)
        
    }
    
    static func showSimpleConfirmationAlert(title: String,message: String, viewRef: UIViewController, actionClosure:@escaping()->Void) {
        
        let advancedAlert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: UIAlertController.Style.alert)
        advancedAlert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: {
            action in
            actionClosure()
        }))
        viewRef.present(advancedAlert, animated: true, completion: nil)
    }
}

protocol IView : UIViewController {}
