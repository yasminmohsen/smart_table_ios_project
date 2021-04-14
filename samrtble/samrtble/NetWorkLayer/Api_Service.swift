//
//  Api_Service.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation
//
//  Api.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation

struct ApIService {
    var phone :String = ""
    var type :String = ""
    
     var url :String {
        
       "https://www.smartble.net/api/\(type)/\(phone)/"
        
    }
    
    
    let headerValue = "Accept-Language"
    
    
}
