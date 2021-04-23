//
//  Api_Service_Extension.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import SwiftyJSON

extension ApiService{
    
   
    
    func fetchNotificationData (completion :@escaping (_ resultNotifData:[ResultNotification]?,_ error:String?)->()){
        
        let apiServiceUrl = ApIServiceUrl(phone: phone, type: type)
        let url = apiServiceUrl.url
     
         if let  urlRequest = URL(string: url){
         let request = NSMutableURLRequest(url: urlRequest)
         if(LanguageOperation.checkLanguage() == .arabic){
                 apiKey = "ar"
             }
             else{
                 apiKey = nil
             }
         if let keyValue = apiKey{

                 request.setValue(keyValue, forHTTPHeaderField: apiServiceUrl.headerValue)
             }
             
             request.httpMethod = "GET"
             let session = URLSession.shared
             let task = session.dataTask(with: request as URLRequest){ [self](data,respone,error) in
                 
                 if let apiData = data {
                     
 //
                     
                     let jsonDict = try?JSON(data: apiData)
                     
                     if let NotificationInfoArray = jsonDict?["data"].array{
                         
                         
                         resultNotification.removeAll()
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
                         
                
                        
                         var arr = notificationTableModel.map({$0.dateCreated});
                         var sortArray = [String]()
                        
                                 for (index,d) in arr.enumerated(){
                                     if(sortArray.contains(d) == false){
                                         sortArray.append(d)
                                     }
                                 
                         
                         }
                         
                             

                         
                         for (index,dateName) in sortArray.enumerated() {
                             resultNotification.append(ResultNotification(date: dateName, data: []))
                         }
                         
                         for (index,dateName) in sortArray.enumerated() {
                             
                             for obj in notificationTableModel{
                                 
                                 if(obj.dateCreated == dateName){
                                     
                                     resultNotification[index].data.append(obj)
                                 }
                                 else{
                                     continue
                                 }
                                 
                                 
                             }
                             
                             
                         }
                         
                         
                        completion(resultNotification,nil)
                         
                     }
                     
                     
                     if let message = jsonDict?["message"].string {
                         
                         
                         if(!message.isEmpty){
                             
                            completion(nil,message)
                             
                         }
                     }
                     
                     
                 }
                 
             }
             task.resume()
             
             
         }
         
         
     }
 
    }
    
