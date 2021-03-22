//
//  LoginViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation
import SwiftyJSON

class LoginViewModel {
    
    
    var bindLogingModel:(_ error:String?,_ data:[TableInfoModel]? )->()={erro,data in }
    
    var error :String = "" {
        
        didSet{
            
            bindLogingModel(error, nil)
        }
        
    }
    var data : [TableInfoModel]! {
        
        didSet{
            
            bindLogingModel(nil, data)
        }
        
    }
    
    
    
    func login(phone:String,key:String?){
        
        let apiService = ApIService(phone: phone)
        let url = apiService.url
        if let  urlRequest = URL(string: url){
            let request = NSMutableURLRequest(url: urlRequest)
            
            
            if let keyValue = key{
                
                request.setValue(keyValue, forHTTPHeaderField: apiService.headerValue)
            }
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest){(data,respone,error) in
                
                if let apiData = data {
                    
                    var tableModelArray = [TableInfoModel]()
                    
                    let stringData = String(data: apiData, encoding:.utf8)!
                    let parsedData = stringData.decodingUnicodeCharacters
                    
                    
                    let jsonDict = try?JSON(data: apiData)
                    
                    if let tableInfoArray = jsonDict?["data"].array{
                        
                        var CellsModelArray = [TableCellModel]()
                        var dayModelArray = [String]()
                        var classesModelArray = [ClassModel]()
                        
                        
                        
                        for tableInfoObj in tableInfoArray {
                            
                            let school_name = tableInfoObj["school_name"].string ?? ""
                            let school_system = tableInfoObj["school_system"].string ?? ""
                            let school_system_text = tableInfoObj["school_system_text"].string ?? ""
                            let teacher_name = tableInfoObj["teacher_name"].string ?? ""
                            let teacher_nickname = tableInfoObj["teacher_nickname"].string ?? ""
                            let teacher_assigned_coun = tableInfoObj["teacher_assigned_count"].string ?? ""
                            let teacherCellsArray =  tableInfoObj["teacher_cells"].array ?? nil
                            let days =  tableInfoObj["days"].array! ?? nil
                            let classes = tableInfoObj["classes"].array ?? nil
                            
                            if let teacherCellArray = teacherCellsArray {
                                
                                for teacherCellObj in teacherCellArray {
                                    
                                    let day = teacherCellObj["day"].string ?? ""
                                    let class_number = teacherCellObj["class_number"].int ?? 0
                                    let cell_text =  teacherCellObj["cell_text"].string ?? nil
                                    
                                    var obj = TableCellModel(day: day, class_number: class_number, cell_text: cell_text)
                                    CellsModelArray.append(obj)
                                    
                                }
                                
                            }
                            
                            if let days = days {
                                for d in days {
                                    let day = d.string ?? ""
                                    dayModelArray.append(day)
                                }}
                            
                            
                            
                            if let classes = classes {
                                
                                for classobj in classes{
                                    let number = classobj["number"].int ?? 0
                                    let start_time = classobj["start_time"].string ?? ""
                                    let end_time = classobj["end_time"].string ?? ""
                                    
                                    var obj = ClassModel(number: number, start_time: start_time, end_time: end_time)
                                    classesModelArray.append(obj)
                                    
                                }
                                
                                
                            }
                            
                            var tableObj = TableInfoModel(school_name: school_name, school_system: school_system, school_system_text: school_system_text, teacher_name: teacher_name, teacher_nickname: teacher_nickname, teacher_assigned_count: teacher_assigned_coun, teacher_cells: CellsModelArray, days: dayModelArray, classes: classesModelArray)
                            
                            tableModelArray.append(tableObj)
                            
                            
                        }
                        
                        
                        self.data = tableModelArray
                        print (data)
                        
                    } // end
                    
                    
                    if let message = jsonDict?["message"].string {
                        
                        
                        if(!message.isEmpty){
                            
                            self.error = message
                        }
                    }
                    
                    
                }
                
            }
            task.resume()
            
            
        }
        
        
    }
    
    
    
    
    
    
}
extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}
