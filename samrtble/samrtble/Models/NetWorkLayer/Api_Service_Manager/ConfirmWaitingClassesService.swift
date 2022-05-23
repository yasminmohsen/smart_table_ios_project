//
//  ConfirmWaitingClassesService.swift
//  samrtble
//
//  Created by Hassan  khamis  on 23/05/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
class ConfirmWaitingClassesService{
    func confirmWaitingClassAsync(url:String, completion: @escaping (_ success: Bool?, _ error: String?) -> ()) {
//        DispatchQueue.init(label: "ds").async {
//            Thread.sleep(forTimeInterval: 1)
//            DispatchQueue.main.async {
//                completion(nil, "fjsdfjids")
//            }
//        }
        let request :Alamofire.DataRequest!
        var headerValue:HTTPHeader?
        let arabicHeaderValue = HTTPHeader(name: "Accept-Language", value: "ar")

        if(LanguageOperation.checkLanguage() == .arabic){
            headerValue = arabicHeaderValue
             request = AF.request(url, method: .get, headers: [headerValue!])
           
        }
        else{
            headerValue = nil
             request = AF.request(url, method: .get)
        }
        
        request.responseJSON { [self] (response) in
            print(response.data)
            if let apiData = response.data {
                 
                 
                let jsonDict = try?JSON(data: apiData)
                
                if let success = jsonDict?["success"].boolValue {
                    if success == true {
                        completion(success,nil)
                    }
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
