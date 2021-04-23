//
//  ActivityIndicatorBehaviour.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import UIKit
class ActivityIndecatorBehaviour {
    
    static func activityIndecatorAction(activityIndecator: UIActivityIndicatorView! ,status:ActivityIndicatorStatus ){
        
        switch status {
        case .start:
            activityIndecator.startAnimating()
            activityIndecator.alpha = 1
        case .stop:
            activityIndecator.stopAnimating()
            activityIndecator.alpha = 0
        default:
            break
        }
        
        
    }
    
}


enum ActivityIndicatorStatus {
    
    case start
    case stop
    
    
}
