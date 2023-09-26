//
//  ResponseModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 21/03/2021.
//

import Foundation

struct Response: Codable {
    var success: Bool
    var data: [TableInfoModel]
    var message: String
}
