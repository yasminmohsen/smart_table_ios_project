//
//  ResponseModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 21/03/2021.
//

import Foundation
struct Response: Codable {
    let success: Bool
    let data: [TableInfoModel]
    let message: String
}
