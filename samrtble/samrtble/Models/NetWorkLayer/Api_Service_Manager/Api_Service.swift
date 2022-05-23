//
//  Api_Service.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation
import SwiftyJSON
import Alamofire

import Foundation



class ApiService {
    var phone :String
    var type :String
    var apiKey : String?
    var notificationTableModel = [NotificationData]()
    var resultNotification = [ResultNotification]()
    
    init(phone:String , type:String) {
        self.phone = phone
        self.type = type
    }
    
    
    // MARK:Fetch Data For HomeScreen :-
    
    func fetchData(completion : @escaping (_ tableModelArray:[TableInfoModel]?,_ error:String?)->())  {
        let apiServiceUrl = ApIServiceUrl(phone: phone, type: type)
        let request :Alamofire.DataRequest!
        let url = apiServiceUrl.url
        var headerValue:HTTPHeader?
        
        if(LanguageOperation.checkLanguage() == .arabic){
            headerValue = apiServiceUrl.arabicHeaderValue
             request = AF.request(url, method: .get, headers: [headerValue!])
    
        }
        else{
            headerValue = nil
             request = AF.request(url, method: .get)
        }
        
        request.responseJSON { (response) in
            print(response.data)
            if let apiData = response.data {
                 
                 var tableModelArray = [TableInfoModel]()
                 
                 let stringData = String(data: apiData, encoding:.utf8)!
                 //let parsedData = stringData.decodingUnicodeCharacters
                 
                 
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
                        
                        let enableTime = tableInfoObj["enable_time"].boolValue ?? false
                        let currentClass = tableInfoObj["current_class"].string ?? ""
                        let nextClass = tableInfoObj["next_class"].string ?? ""
                        
                         let teacherCellsArray =  tableInfoObj["teacher_cells"].array ?? nil
                         let coloredDay = tableInfoObj["day"].string ?? ""
                         let time = tableInfoObj["time"].string ?? ""
                         let date = tableInfoObj["date"].string ?? ""
                         let days =  tableInfoObj["days"].array! ?? nil
                         let classes = tableInfoObj["classes"].array ?? nil
                         
                         if let teacherCellArray = teacherCellsArray {
                             
                             for teacherCellObj in teacherCellArray {
                                 
                                 let day = teacherCellObj["day"].string ?? ""
                                 let class_number = teacherCellObj["class_number"].int ?? 0
                                 var cell_text =  teacherCellObj["cell_text"].string ?? "-"
                                 let isWaiting = teacherCellObj["is_waiting"].boolValue ?? false
                                 let confirm_link = teacherCellObj["confirm_link"].string
                                 let wc_priority = teacherCellObj["wc_priority"].string
                                 let confirmed = teacherCellObj["confirmed"].boolValue ?? false

//                                 if (isWaiting == true){
//                                     cell_text = 
//                                 }
//                                 
                                 
                                 var obj = TableCellModel(day: day, class_number: class_number, cell_text: cell_text,isWaiting: isWaiting,confirm_link: confirm_link, wc_priority: wc_priority, confirmed: confirmed)
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
                         
                        var tableObj = TableInfoModel(school_name: school_name, school_system: school_system, school_system_text: school_system_text, teacher_name: teacher_name, teacher_nickname: teacher_nickname, teacher_assigned_count: teacher_assigned_coun,enable_time:enableTime,current_class:currentClass
                        , next_class: nextClass,teacher_cells: CellsModelArray, days: dayModelArray, classes: classesModelArray,date: date ,time: time,day: coloredDay )
                         
                         tableModelArray.append(tableObj)
                         
                         CellsModelArray.removeAll()
                         dayModelArray.removeAll()
                         classesModelArray.removeAll()
                     }
                     
                     
                     completion(tableModelArray,nil)
                     
                     
                 } // end
                 
                 
                 if let message = jsonDict?["message"].string {
                     
                     
                     if(!message.isEmpty){
                         
                         completion(nil,message)
                         print(message)
                     }
                 }
                 
                 
             }
            
            
            if let error = response.error{
                print(error.localizedDescription)
            }
        }
  
}


}
