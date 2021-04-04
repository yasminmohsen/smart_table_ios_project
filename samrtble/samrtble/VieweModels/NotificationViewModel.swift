//
//  NotificationViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 03/04/2021.
//

import Foundation
import SwiftyJSON
class NotificationViewModel {
    
    var notificationTableModel = [NotificationData]()
  
    var resultNotification = [ResultNotification]()
    var apiKey :String?
    
    var bindNotificationModel:(_ error:String?,_ data:[ResultNotification]? )->()={erro,data in }
    
    var error :String = "" {
        
        didSet{
            
            bindNotificationModel(error, nil)
        }
        
    }
    var data : [ResultNotification]! {
        
        didSet{
            
            bindNotificationModel(nil, data)
        }
        
    }
    
    
    
    func fetchData(){
        
        guard let phone = UserDefaults.standard.string(forKey: MainLoginViewController.PHONE_KEY) else { return  }
       let apiService = ApIService(phone: phone, type: "notif-history")
       let url = apiService.url
    
        if let  urlRequest = URL(string: url){
        let request = NSMutableURLRequest(url: urlRequest)
        if(LanguageOperation.checkLanguage() == .arabic){
                apiKey = "ar"
            }
            else{
                apiKey = nil
            }
        if let keyValue = apiKey{

                request.setValue(keyValue, forHTTPHeaderField: apiService.headerValue)
            }
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest){ [self](data,respone,error) in
                
                if let apiData = data {
                    
//
                    
                    let jsonDict = try?JSON(data: apiData)
                    
                    if let NotificationInfoArray = jsonDict?["data"].array{
                        
            
                        notificationTableModel.removeAll()
                        
                        for notifObj in NotificationInfoArray {
                            
                            let title = notifObj["title"].string ?? ""
                            let body = notifObj["body"].string ?? ""
                            let date = notifObj["date_created"].string ?? ""
                            let time_created = notifObj["time_created"].string ?? ""
                            let actionId = notifObj["action_id"].string ?? ""
                            
                            var notifcationObj = NotificationData(title: title, body: body, actionID: actionId, dateCreated: date, timeCreated: time_created, priority: nil, clickAction: nil)
                            
                            self.notificationTableModel.append(notifcationObj)
                            
                        }
                        
                        var notificationTableResult = Dictionary(grouping: notificationTableModel, by: {$0.dateCreated})
                        
                        
                        
                        for obj in notificationTableResult{
                            resultNotification.removeAll()
                            resultNotification.append(ResultNotification(date: obj.key, data: obj.value))
                        }
                        
               
                        self.data = resultNotification
                        
                    }
                    
                    
                    if let message = jsonDict?["message"].string {
                        
                        
                        if(!message.isEmpty){
                            
                           // self.error = message
                            // alert here 
                        }
                    }
                    
                    
                }
                
            }
            task.resume()
            
            
        }
        
        
    }
    
    
    
    
    
    
}
    
    
    
    
    
    
    
    
    

