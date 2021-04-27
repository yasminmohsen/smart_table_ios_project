//
//  RemoteNotificationModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 18/04/2021.
//

import Foundation
import UIKit

class RemoteNotificationViewModel {
    
    static var FCMTOKEN_KEY = "fcm_token_key"

    
    func fetchRemoteNotification() {
        if let phone = UserDefaults.standard.string(forKey: MainLoginViewController.PHONE_KEY){
            if let fcmToken = UserDefaults.standard.string(forKey: RemoteNotificationViewModel.FCMTOKEN_KEY){

            let apiService = ApiService(phone: phone, type: "fcm-token")
                
                apiService.fetchRemOteNotification(completeion: { (result) in
         
                    print("-----------------\n result is : \(result)\n-----------------------")
                    
                }, fcmToken: fcmToken)
                
                

        }
       
        }
        
    }
    
    
    
}
