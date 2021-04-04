//
//  NotificationModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 03/04/2021.
//

import Foundation


// MARK: - NotificationResponse
struct NotificationResponse: Codable {
    let success: Bool
    let data: [NotificationData]
    let message: String
}

// MARK: - NotificationData
struct NotificationData: Codable {
    let title, body, actionID ,dateCreated, timeCreated: String
    
    let priority,clickAction: String?
    
    enum CodingKeys: String, CodingKey {
        case title, body
        case actionID = "action_id"
        case clickAction = "click_action"
        case priority
        case dateCreated = "date_created"
        case timeCreated = "time_created"
    }
    
    
}


struct ResultNotification {
    var date : String
    var data : [NotificationData]
}
