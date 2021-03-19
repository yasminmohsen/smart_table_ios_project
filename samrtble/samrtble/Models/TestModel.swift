//
//  TestModel.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import Foundation


class TestModel {
    
    static func testModelObj() -> [TableInfoModel]{
        
        var tableCellModelobj1 = TableCellModel(day: "sunday", class_number: "1", cell_text: "Quraan")
        var tableCellModelobj2 = TableCellModel(day: "sunday", class_number: "2", cell_text: "None")
        var tableCellModelobj3 = TableCellModel(day: "sunday", class_number: "3", cell_text: "Tawheed")
        var tableCellModelobj4 = TableCellModel(day: "sunday", class_number: "4", cell_text: "English")
        var tableCellModelobj5 = TableCellModel(day: "sunday", class_number: "5", cell_text: "None")
        var tableCellModelobj6 = TableCellModel(day: "sunday", class_number: "6", cell_text: "Quraan")
        var tableCellModelobj7 = TableCellModel(day: "sunday", class_number: "7", cell_text: "Arabic")
        var tableCellModelobj21 = TableCellModel(day: "Monday", class_number: "1", cell_text: "None")
        var tableCellModelobj22 = TableCellModel(day: "Monday", class_number: "2", cell_text: "Frensh")
        var tableCellModelobj23 = TableCellModel(day: "Monday", class_number: "3", cell_text: "Maths")
        var tableCellModelobj24 = TableCellModel(day: "Monday", class_number: "4", cell_text: "Bilolgy")
        var tableCellModelobj25 = TableCellModel(day: "Monday", class_number: "5", cell_text: "Chimestry")
        var tableCellModelobj26 = TableCellModel(day: "Monday", class_number: "6", cell_text: "hadith")
        var tableCellModelobj27 = TableCellModel(day: "Monday", class_number: "7", cell_text: "None")
        
        
        
        var cellsArray = [tableCellModelobj1,tableCellModelobj2,tableCellModelobj3,tableCellModelobj4,tableCellModelobj5,tableCellModelobj6,tableCellModelobj7,tableCellModelobj21,tableCellModelobj22,tableCellModelobj23,tableCellModelobj24,tableCellModelobj25,tableCellModelobj26,tableCellModelobj27,tableCellModelobj1,tableCellModelobj2,tableCellModelobj3,tableCellModelobj4,tableCellModelobj5,tableCellModelobj6,tableCellModelobj7,tableCellModelobj21,tableCellModelobj22,tableCellModelobj23,tableCellModelobj24,tableCellModelobj25,tableCellModelobj26,tableCellModelobj27,tableCellModelobj1,tableCellModelobj2,tableCellModelobj3,tableCellModelobj4,tableCellModelobj5,tableCellModelobj6,tableCellModelobj7]
        
        
        
        
        
        
        var daysArray = ["Sunday","Monday","Tuesday","Wednsday","Thursday"]
        
        
        
        
        
        var class1 = ClassModel(number: 1, start_time: "7:30", end_time: "8:15")
        var class2 = ClassModel(number: 2, start_time: "8:30", end_time: "9:15")
        var class3 = ClassModel(number: 3, start_time: "9:30", end_time: "10:15")
        var class4 = ClassModel(number: 4, start_time: "10:30", end_time: "11:15")
        var class5 = ClassModel(number: 5, start_time: "11:30", end_time: "12:15")
        var class6 = ClassModel(number: 6, start_time: "12:30", end_time: "1:15")
        var class7 = ClassModel(number: 7, start_time: "1:30", end_time: "2:15")
        
        
        var classArray = [class1,class2,class3,class4,class5,class6,class7]
        
        
        
        
        var testModel_1 = TableInfoModel(school_name: "Delta", school_system: "Acadedmic", school_system_text: "academic", teacher_name: "Ayman doby", teacher_nickname: "Ayman doby", teacher_assigned_count: 6, teacher_cellModels: cellsArray, days: daysArray,classes: classArray)
        
        
        var testModel_2 = TableInfoModel(school_name: "Madina", school_system: "Acadedmic", school_system_text: "academic", teacher_name: "Ayman doby", teacher_nickname: "Ayman doby", teacher_assigned_count: 6, teacher_cellModels: cellsArray, days: daysArray,classes: classArray)
        
        
        var testModelsArray = [testModel_1,testModel_2]
        
        
        return testModelsArray
        
        
        
        
        
        
        
        
    }
    
    
    
    
}
