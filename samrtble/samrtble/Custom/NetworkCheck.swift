//
//  NetworkCheck.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import Network


class InternetCheckConnection {
    
    
    
    static func checkIntener(_ iCheckNetworkConnection :IcheckNetworkConnection){

          let monitor = NWPathMonitor(requiredInterfaceType: .wifi)
          let queue = DispatchQueue(label: "InternetConnectionMonitor")
                            

                 monitor.pathUpdateHandler = { pathUpdateHandler in
                  if pathUpdateHandler.status == .satisfied {
                                print("Internet connection is on.")
                            
                    iCheckNetworkConnection.onSucessConnected()
                    
                                 // self.fetchData(phone: phone)
                
                            }
                            else{
                            
                                  print("Internet connection is off.")
                                iCheckNetworkConnection.onFailurConnected()
                                  //self.netWorkError = "no internet connection"
                        
                             
                           
                     }
                 
             
             }
                 
          monitor.start(queue: queue)
        
        
    }

    
}


