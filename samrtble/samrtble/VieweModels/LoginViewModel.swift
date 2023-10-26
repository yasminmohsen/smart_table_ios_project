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

var USER_TOKEN = "SMART_TABLE_TOKEN"
class LoginViewModel {
    
    let userRegisteredBeforePublisher = PassthroughSubject<Void, Never>()
    let unRegisteredUserPublisher = PassthroughSubject<Void, Never>()
    let showErrorPublisher = PassthroughSubject<String, Never>()
    
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
    
    var userCode: String?
    
    // MARK: - Functions :-
    
    func login(with userName: String, password: String) {
        Task { [weak self] in
            guard let self else { return }
            do {
                if let response =  try await NetworkManager.login(appService: .login(user: User(code: "", userName: userName, password: password, email: ""))) {
                    self.saveTokenToUserDefult(token: response.token)
                    self.fetchDataFromApi(phone: userName)
                }
            } catch NetworkError.withMessage(let message) {
                self.showErrorPublisher.send(message)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    func register(with userCode: String, userName: String = "", password: String = "", email: String = "") {
        Task { [weak self] in
            guard let self else { return }
            do {
                if let response =  try await NetworkManager.register(appService: .register(user: User(code: userCode, userName: userName, password: password, email: email))) {
                    self.saveTokenToUserDefult(token: response.token)
                    self.fetchDataFromApi(phone: userName)
                }

            } catch NetworkError.notRegisteredBefore(let error) {
                self.unRegisteredUserPublisher.send()
                self.showErrorPublisher.send(error)
            } catch NetworkError.registeredBefore {
                self.userRegisteredBeforePublisher.send()
            }  catch NetworkError.withMessage(let message) {
                self.showErrorPublisher.send(message)
            }  catch {
                self.showErrorPublisher.send(error.localizedDescription)
            }
        }
    }
    
    func saveTokenToUserDefult(token:String) {
        UserDefaults.standard.set(token, forKey: USER_TOKEN)
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





