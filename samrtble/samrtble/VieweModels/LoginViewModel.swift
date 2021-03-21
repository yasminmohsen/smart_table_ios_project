//
//  LoginViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation


class LoginViewModel {
    
   
    var bindLogingModel:(_ error:String?,_ data:[TableInfoModel]? )->()={erro,data in }
    
    var error :String = "" {
        
        didSet{
            
            bindLogingModel(error, nil)
        }
        
    }
    var data : [TableInfoModel]! {
        
        didSet{
            
            bindLogingModel(nil, data)
        }
        
    }
    
    
    
    func login(phone:String,key:String?){
        
        let apiService = ApIService(phone: phone)
        let url = apiService.url
        if let  urlRequest = URL(string: url){
            let request = NSMutableURLRequest(url: urlRequest)
           
            
            if let keyValue = key{
                
                request.setValue(keyValue, forHTTPHeaderField: apiService.headerValue)
            }
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest){(data,respone,error) in
                
                if let apiData = data {
                    print(data)
                    let stringData = String(data: apiData, encoding: .utf8)!
                    print(stringData)
                    
                    let jsonDecoder = JSONDecoder()
                    let apiResponse = try? jsonDecoder.decode(Response.self, from: apiData)
                    
                    if let result = apiResponse?.data {
                        
                        self.data = result
                    }
                    
                    if let message = apiResponse?.message{
                        if(!message.isEmpty){
                            self.error = message
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            task.resume()
            

        }
        
       
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
