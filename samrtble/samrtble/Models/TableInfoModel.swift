//
//  TableInfoModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

struct TableInfoModel : Codable {
    /*
     case schoolName = "school_name"
            case schoolSystem = "school_system"
            case schoolSystemText = "school_system_text"
            case teacherName = "teacher_name"
            case teacherNickname = "teacher_nickname"
            case teacherAssignedCount = "teacher_assigned_count"
            case teacherCells = "teacher_cells"
            case days, classes
     */
    var school_name: String
    var school_system: String
   var school_system_text: String
    var teacher_name: String
   var teacher_nickname: String
   var teacher_assigned_count: String
   var teacher_cells: [TableCellModel]
   var days:[String]
   var classes :[ClassModel]
}


