//
//  NotificationViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 03/04/2021.
//

import Foundation
import SwiftyJSON
import Network
import Alamofire
class NotificationViewModel {
    
    var resultNotification = [ResultNotification]()
    
    
    var bindNotificationModel:(_ error:String?,_ data:[ResultNotification]?, _ netWorkError:String?)->()={erro,data,netWorkError in }
    
    var error :String = "" {
        
        didSet{
            
            bindNotificationModel(error, nil,nil)
        }
        
    }
    var data : [ResultNotification]! {
        
        didSet{
            
            bindNotificationModel(nil, data,nil)
        }
        
    }
    
    
    
    var netWorkError :String = ""{
        
        didSet{
            
            bindNotificationModel(nil,nil,netWorkError)
            
            
        }
        
    }
    
    
    
    
    func fetchDataFromApi() {
      
        weak var weakSelf = self
        InternetCheckConnection().checkIntener(weakSelf!)
     
        
    }
    
    
    
    
    
    
    func fetchData(){
        
        guard let phone = UserDefaults.standard.string(forKey: MainLoginViewController.PHONE_KEY) else { return  }
        
        let apiService = ApiService(phone: phone, type: "notif-history")
        
        apiService.fetchNotificationData { (notificationData, error) in
            
            
            if let resultNotif = notificationData {
                
                self.data = resultNotif
                
            }
            if let error = error {
                
                self.error = error
            }
            
        }
    }
    
    
}


extension NotificationViewModel :IcheckNetworkConnection{
    func onSucessConnected() {

        self.fetchData()

    }

    func onFailurConnected() {

        self.netWorkError = "no internet connection"
    }


}








