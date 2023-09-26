//
//  LoginViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation
import SwiftyJSON
import Network
import Alamofire
class LoginViewModel {
    
    var phone:String = ""
    var bindLogingModel:(_ error:String?,_ result:Result?, _ networkError :String?)->()={erro,result,newtWorkError in }
    var error :String = "" {
        didSet{
            
            bindLogingModel(error, nil,nil)
        }
    }
    var result : Result! {
        
        didSet{
            
            bindLogingModel(nil,result,nil)
        }
        
    }
    
    var netWorkError :String = "" {
        
        didSet{
            bindLogingModel(nil,nil,netWorkError)
        }
        
    }
    
    
    // MARK: - Functions :-
    
    func fetchDataFromApi(phone:String) {
        self.phone = phone
        let isConnecte = NetworkReachabilityManager()?.isReachable ?? false
        if isConnecte{
            self.fetchData(phone: phone)
        }
        else{
            print("Internet connection is off.")
            self.netWorkError = "no internet connection"
        }
        
    }
    
    func fetchData(phone:String){
        
        let apiService = ApiService(phone: phone, type: "teacher-table")
        apiService.fetchData { [weak self](tableInfoModelArray, error) in
            
            guard let self = self else{return}
            
            if let tableInfoArray = tableInfoModelArray {
                self.result = .success
                
            }
            
            if let error = error{
                
                self.error = error
            }
            
        }
        
    }
    
}





