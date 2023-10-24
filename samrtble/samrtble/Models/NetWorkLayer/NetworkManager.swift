//
//  NetworkManager.swift
//  samrtble
//
//  Created by Mahmoud Abdulwahab on 21/10/2023.
//

import Foundation
struct User {
    let code, userName, password, email: String
}

enum AppService {
    case login(user: User)
    case register(user: User)
    case forgetPassword(email: String)
    case fetchTableData
    case fetchNotificationHistory
    
    var url: URL {
        switch self {
        case .login:
            return  URL(string: "https://www.smartble.net/teacher-mobile/login/")!
        case .register:
            return  URL(string: "https://www.smartble.net/teacher-mobile/register/")!
        case .forgetPassword:
            return URL(string: "https://www.smartble.net/teacher-mobile/reset-password/")!
        case .fetchTableData:
            return URL(string: "https://www.smartble.net/teacher-mobile/table/")!
        case .fetchNotificationHistory:
            return URL(string: "https://www.smartble.net/teacher-mobile/notif-history/")!
            
        }
    }
    
    var httpMethod: String {
        switch self {
        case .login, .register, .forgetPassword:
            return "POST"
        case .fetchTableData, .fetchNotificationHistory:
            return "GET"
        }
    }

    var body: Data? {
        switch self {
        case .login(let user):
            let parameters: [String: Any] = [
                "username": user.userName,
                "password": user.password
            ]
            return try? JSONSerialization.data(withJSONObject: parameters)
        case .register(let user):
            let parameters: [String: Any] = [
                "user_code": user.code,
                "username": user.userName,
                "password": user.password,
                "email": user.email
            ]
            return try? JSONSerialization.data(withJSONObject: parameters)
            
        case .forgetPassword(let email):
            let parameters: [String: Any] = [
                "email": email
            ]
            return try? JSONSerialization.data(withJSONObject: parameters)
        case .fetchTableData, .fetchNotificationHistory:
            return nil
        }
    }
    
    var headers: [String: String]? {
         [
            "Accept-Language": LanguageOperation.checkLanguage() == .arabic ? "ar":"en",
            "Content-Type": "application/json"
        ]
    }
    
    static func makeURLRequest(service: AppService) -> URLRequest {
        var request = URLRequest(url: service.url)
        request.httpMethod = service.httpMethod
        request.method = .post
        request.httpBody = service.body
        request.allHTTPHeaderFields = service.headers
        return request
    }
}

enum NetworkError: Error {
    case invalidURL
    case withMessage(String)
    case invalidResponse
    case invalidData
    case decodingError(Error)
    case notRegisteredBefore(String)
    case registeredBefore(String)
}

class LoggingDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let bodyString = String(data: data, encoding: .utf8) {
            print("Response Body: \(bodyString)")
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("Bytes Sent: \(totalBytesSent) out of \(totalBytesExpectedToSend)")
    }
}




class NetworkManager {
    
    static  func login(appService: AppService) async throws -> Bool {
        let (data, response) = try await URLSession.shared.data(for: AppService.makeURLRequest(service: appService))
        if  let response = response as? HTTPURLResponse {
            print("💥💥💥",response.statusCode)
            if (200...299).contains(response.statusCode)  {
                return true
            }else {
                throw NetworkError.invalidData
            }
        } else {
            throw NetworkError.invalidData
        }
    }
    
    static func register(appService: AppService) async throws  -> Bool  {
        

        let config = URLSessionConfiguration.default
        config.urlCache = nil
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
//
//
//        let user = User(code: "00350", userName: "", password: "", email: "")
//
//        let url = URL(string: "https://www.smartble.net/teacher-mobile/register/")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // Set headers
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("ar", forHTTPHeaderField: "Accept-Language")
//
//        // Create request body
//        let requestBody: [String: Any] = [
//            "user_code": user.code,
//            "username": user.userName,
//            "password": user.password,
//            "email": user.email
//        ]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
//        } catch {
//            throw NetworkError.invalidResponse
//        }
        
        let (data, response) = try await session.data(for: AppService.makeURLRequest(service: appService))
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        print("🚀:--------", httpResponse.statusCode)
        if (200...299).contains(httpResponse.statusCode) {
            // Successful response
            return true
        } else if httpResponse.statusCode == 409 {
            // Handle 409 conflict error
            if let errorMessage = String(data: data, encoding: .utf8) {
                throw NetworkError.notRegisteredBefore(errorMessage)
            } else {
                throw NetworkError.withMessage("Unknown Error")
            }
        } else if httpResponse.statusCode == 400 {
            // Handle 400 bad request error
            if let errorMessage = String(data: data, encoding: .utf8) {
                throw NetworkError.withMessage(errorMessage)
            } else {
                throw NetworkError.withMessage("Unknown Error")
            }
        } else {
            // Other errors
            throw NetworkError.withMessage("HTTP Status Code: \(httpResponse.statusCode)")
        }
    }
    
    
    static  func forgetPassword(appService: AppService) async throws -> Bool {
        let (data, response) = try await URLSession.shared.data(for: AppService.makeURLRequest(service: appService))
        if  let response = response as? HTTPURLResponse {
            print("💥💥💥",response.statusCode)
            if (200...299).contains(response.statusCode)  {
                return true
            }else {
                throw NetworkError.invalidData
            }
        } else {
            throw NetworkError.invalidData
        }
    }
    
    func makeRequest<T: Decodable>(request: AppService, modelType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: AppService.makeURLRequest(service: request))
      
       if  let response = response as? HTTPURLResponse{
           if response.statusCode == 409 {
               throw NetworkError.notRegisteredBefore("")
           }
          if (200...299).contains(response.statusCode)  {
              let decoder = JSONDecoder()
              let decodedData = try decoder.decode(T.self, from: data)
              return decodedData
          } else {
              throw NetworkError.invalidResponse
          }
           
        }
        throw NetworkError.invalidResponse
    }
    
}
