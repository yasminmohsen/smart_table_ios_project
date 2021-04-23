//
//  ApiServiceUrl.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation


struct ApIServiceUrl {
    var phone :String = ""
    var type :String = ""
    
     var url :String {
        
       "https://www.smartble.net/api/\(type)/\(phone)/"
        
    }
    
    
    let headerValue = "Accept-Language"
}
