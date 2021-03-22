//
//  BarItems.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/03/2021.
//

import Foundation
import UIKit

class BarItem {
    
    
    
    
    
    lazy var leftBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
        CustomButton.customBarButton(btnBack: btnBack, title: "Logout")

               btnBack.addTarget(self, action: #selector(logOutClicked(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()
    
    
}
