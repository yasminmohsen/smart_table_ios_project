//
//  RemoteNotificationModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 18/04/2021.
//

import Foundation

class RemoteNotificationModel {
    
    
    
    static func sendTokenToApi(_ token :String){
        
        
        let api = ""
        if let url = URL(string: api){
            
            let requset = NSMutableURLRequest(url: url)
            requset.httpMethod = ""
            let session = URLSession.shared
            let task = session.dataTask(with: requset as URLRequest) { (data, response, error) in
                
                
                
                
            }
                
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
}
