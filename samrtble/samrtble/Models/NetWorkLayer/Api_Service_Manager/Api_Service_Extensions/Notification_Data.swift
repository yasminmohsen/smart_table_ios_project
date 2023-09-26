
//  Api_Service_Extension.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import SwiftyJSON
import Alamofire

extension ApiService{
    
    // MARK: -Fetch Data For Notification :-
    
    func fetchNotificationData (completion :@escaping (_ resultNotifData:[ResultNotification]?,_ error:String?)->()){
        let apiServiceUrl = ApIServiceUrl(phone: phone, type: type)
        let url = apiServiceUrl.url
        let request :Alamofire.DataRequest!
        var headerValue:HTTPHeader?
        if(LanguageOperation.checkLanguage() == .arabic){
            headerValue = apiServiceUrl.arabicHeaderValue
            request = AF.request(url, method: .get, headers: [headerValue!])
        }
        else {
            headerValue = nil
            request = AF.request(url, method: .get)
        }
        request.responseJSON { [self] (response) in
            print(response.data)
            if let apiData = response.data {
                let jsonDict = try?JSON(data: apiData)
                if let NotificationInfoArray = jsonDict?["data"].array{
                    self.resultNotification.removeAll()
                    self.notificationTableModel.removeAll()
                    for notifObj in NotificationInfoArray {
                        let title = notifObj["title"].string ?? ""
                        let body = notifObj["body"].string ?? ""
                        let date = notifObj["date_created"].string ?? ""
                        let time_created = notifObj["time_created"].string ?? ""
                        let actionId = notifObj["action_id"].string ?? ""
                        var notifcationObj = NotificationData(title: title, body: body, actionID: actionId, dateCreated: date, timeCreated: time_created, priority: nil, clickAction: nil)
                        self.notificationTableModel.append(notifcationObj)
                    }
                    var arr = self.notificationTableModel.map({$0.dateCreated});
                    var sortArray = [String]()
                    
                    for (index,d) in arr.enumerated(){
                        if(sortArray.contains(d) == false){
                            sortArray.append(d)
                        }
                    }
                    for (index,dateName) in sortArray.enumerated() {
                        self.resultNotification.append(ResultNotification(date: dateName, data: []))
                    }
                    for (index,dateName) in sortArray.enumerated() {
                        
                        for obj in self.notificationTableModel{
                            
                            if(obj.dateCreated == dateName){
                                
                                self.resultNotification[index].data.append(obj)
                            }
                            else{
                                continue
                            }
                        }
                        
                    }
                    completion(self.resultNotification,nil)
                    
                }
                if let message = jsonDict?["message"].string {
                    if(!message.isEmpty){
                        completion(nil,message)
                        
                    }
                }
                
            }
        }
    }
    
}



