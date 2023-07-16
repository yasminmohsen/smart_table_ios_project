//
//  HomeViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import SwiftyJSON
import Network
import Alamofire
import Firebase
class HomeViewModel {
    
    
    var classesArray = [[[(String,Bool, String?, String?,Bool?)]]]()
    var classesNumber = [[ClassModel]]()
    var day :String!
    var daysArray = [String]()
    var schoolNames = [String]()
    var teacherName = ""
    var phone :String = ""
    var currentClass :String = ""
    var nextClass :String = ""
    
    
    
    // MARK:Variables :-
    
    var bindLogingModel:(_ error:String?,_ data:[TableInfoModel]? , _ networkError :String?)->()={erro,data,newtWorkError in }
    var openInfoClass:(_ msg:String)->()={msg in }
    var error :String = "" {
        
        didSet{
            
            bindLogingModel(error, nil,nil)
        }
        
    }
    var data : [TableInfoModel]! {
        
        didSet{
            
            bindLogingModel(nil,data,nil)
        }
        
    }
    
    
    var netWorkError :String = "" {
        
        didSet{
            bindLogingModel(nil,nil,netWorkError)
        }
        
        
        
        
    }
    
    
    
    // MARK:Functions :-
    
    func fetchDataFromApi(phone:String) {
        self.phone = phone
        weak var weakSelf = self
        InternetCheckConnection().checkIntener(weakSelf!)
        
    }
    
    
    
    
    
    
    func fetchData(phone:String) {
        
        
        let apiService = ApiService(phone: phone, type: "teacher-table")
        apiService.fetchData { (tableInfoModelArray, error) in
            
            if let tableInfoArray = tableInfoModelArray {
                self.schoolNames.removeAll()
                self.classesArray.removeAll()
                self.classesNumber.removeAll()
                for obj in tableInfoArray{
                    let MappingModel = MappedModel()
                    self.schoolNames.append(obj.school_name)
                    if obj.classes.count > 0 {
                        self.classesArray.append(MappingModel.converTableModelToClasses(obj))
                        self.classesNumber.append(obj.classes)
                    }
                    self.day = obj.day
                    self.currentClass = obj.current_class ?? ""
                    self.nextClass = obj.next_class ?? ""
                    self.daysArray = obj.days
        
                }
                
                self.teacherName = tableInfoArray[0].teacher_name
                self.data = tableInfoArray
            }
            
            
            if let error = error{
                
                
                self.error = error
            }
            
        }
        
        
        
    }
    
    func confirmWaitingClass(link: String, msg: String) {
        guard let phone = UserDefaults.standard.string(forKey: MainLoginViewController.PHONE_KEY) else { return  }
        
        let service = ConfirmWaitingClassesService()
        
        service.confirmWaitingClassAsync(url: link) { (success, error) in
            
            
            if let success = success {
                
                self.fetchDataFromApi(phone: phone)
                self.openInfoClass(msg)
            }
            if let error = error {
                
                self.error = error
            }
            
        }

    }
}



extension HomeViewModel :IcheckNetworkConnection{
    func onSucessConnected() {
        print("Internet connection is on.")

        self.fetchData(phone: phone)
    }

    func onFailurConnected() {
        print("Internet connection is off.")
        self.netWorkError = "no internet connection"
    }


    
    
}
