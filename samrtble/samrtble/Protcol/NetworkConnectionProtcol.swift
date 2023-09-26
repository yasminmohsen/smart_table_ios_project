//
//  NetworkConnectionProtcol.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation

protocol IcheckNetworkConnection: AnyObject  {
    func onSuccessConnected()
    func onFailureConnected()
}
