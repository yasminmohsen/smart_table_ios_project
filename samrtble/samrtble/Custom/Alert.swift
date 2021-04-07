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
}
protocol IView : UIViewController {

}
