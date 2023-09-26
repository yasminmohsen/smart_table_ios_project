//
//  NetworkCheck.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import Network


class InternetCheckConnection {
    weak var iCheckNetworkConnection: IcheckNetworkConnection?
    
    func checkInternet() {
        let  monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                
                self.iCheckNetworkConnection?.onSuccessConnected()
                monitor.cancel()
                
            }
            else{
                print("Internet connection is off.")
                self.iCheckNetworkConnection?.onFailureConnected()
                //self.netWorkError = "no internet connection"
            }
        }
        
        monitor.start(queue: queue)
        
    }
}


