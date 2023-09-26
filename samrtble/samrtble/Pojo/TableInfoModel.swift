//
//  TableInfoModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

struct TableInfoModel : Codable {
    var school_name: String
    var school_system: String
    var school_system_text: String
    var teacher_name: String
    var teacher_nickname: String
    var teacher_assigned_count: String
    var enable_time: Bool
    var current_class: String?
    var next_class: String?
    var teacher_cells: [TableCellModel]
    var days:[String]
    var classes :[ClassModel]
    var date: String
    var time: String
    var day :String
}


