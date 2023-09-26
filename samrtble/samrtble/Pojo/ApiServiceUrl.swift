//
//  ApiServiceUrl.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import Alamofire

struct ApIServiceUrl {
    var phone :String = ""
    var type :String = ""
    var url :String {
        "https://www.smartble.net/api/\(type)/\(phone)/"
    }
    let arabicHeaderValue = HTTPHeader(name: "Accept-Language", value: "ar")
}
