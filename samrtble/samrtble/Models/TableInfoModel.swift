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
   var teacher_assigned_count: Int
   var teacher_cellModels: [TableCellModel]
   var days:[String]
    var classes :[ClassModel]
}


