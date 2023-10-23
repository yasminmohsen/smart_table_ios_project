//
//  LoginViewModel.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 20/03/2021.
//

import Foundation
import Network
import Alamofire
import Combine

class LoginViewModel {
    
    let userRegisteredBeforePublisher = PassthroughSubject<Void, Never>()
    let unRegisteredUserPublisher = PassthroughSubject<Void, Never>()

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
    
    func login(with userName: String, password: String) {
        Task {
            do {
             let isSuccess =  try await NetworkManager.login(appService: .login(user: User(code: "", userName: userName, password: password, email: "")))
                
                if isSuccess {
                    fetchDataFromApi(phone: userName)
                }
                
            } catch (let error) {
                print(error)
            }
        }
    }
    
    func register(with userName: String) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let isSuccess =  try await NetworkManager.register(appService: .register(user: User(code: userName, userName: "", password: "", email: "")))
                
                if isSuccess {
                        
                }
                
            } catch NetworkError.notRegisteredBefore(let error) {
                self.unRegisteredUserPublisher.send()
            } catch NetworkError.registeredBefore {
                self.userRegisteredBeforePublisher.send()
            }  catch {
                print(error)
            }
        }
    }
    
    func fetchDataFromApi(phone:String) {
        self.phone = phone
        let isConnecte = NetworkReachabilityManager()?.isReachable ?? false
        if isConnecte {
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





