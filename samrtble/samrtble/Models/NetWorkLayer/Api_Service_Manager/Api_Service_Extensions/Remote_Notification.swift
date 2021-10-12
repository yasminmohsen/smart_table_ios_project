//
//  Remote_Notification.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/04/2021.
//

import Foundation

import Alamofire
import SwiftyJSON


extension ApiService{
    
    func fetchRemOteNotification (completeion:@escaping (_ result:String)->() ,fcmToken:String){
    
    
         let apiServiceUrl = ApIServiceUrl(phone: phone, type: type)
        let url = apiServiceUrl.url
        let request :Alamofire.DataRequest!
        
        var parameters = ["fcm_token":fcmToken,
                          "package_name":"com.optimalsoft.samrtable"]
        
        var headerValue:HTTPHeader?
        
        if(LanguageOperation.checkLanguage() == .arabic){
            headerValue = apiServiceUrl.arabicHeaderValue
            request = AF.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: [headerValue!])
           
        }
        else{
            headerValue = nil
             request = AF.request(url, method: .post, parameters: parameters,encoding:JSONEncoding.default)
        }
    
    
        
        
        request.responseJSON { (response) in
            
            
            
            print(response.data)
            if let data = response.data{
                let json = try?JSON(data: response.data!)
                print(json)
            }
           
            //completeion(response.data)
            
            
        }
        
        
        
        
        
        
        
        
    
    }

    
    
    
}
