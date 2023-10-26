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
    
    func fetchRemOteNotification (completeion:@escaping (_ result:String)->() ,fcmToken:String) {
        let apiServiceUrl = ApIServiceUrl(phone: phone, type: type)
        let request :Alamofire.DataRequest!
        let url = AppService.updateFcmToken.url
        
        var headerValue:HTTPHeader?
        var header1 = HTTPHeader(name: "auth-token", value: UserDefaults.standard.string(forKey: USER_TOKEN) ?? "")
        
        headerValue = HTTPHeader(name: "Accept-Language", value: LanguageOperation.checkLanguage() == .arabic ? "ar":"en")
        
        var header2 = HTTPHeader(name: "package_name", value:"com.optimalsoft.samrtable")
        
        request = AF.request(url, method: .get, headers: [headerValue!,header1,header2])
     
        request.responseJSON { (response) in
            print(response.data)
            if let data = response.data{
                let json = try?JSON(data: response.data!)
                print(json)
            }
        }
    }
}
