//
//  ClassesViewController.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import UIKit
import SpreadsheetView


class ClassesViewController: UIViewController{

    var sortedColumn = (column: 0, sorting: Sorting.ascending)
    @IBOutlet weak var spreadView: SpreadsheetView!
    
    var tableInfoModel:TableInfoModel!
    var classesArray = [[String]]()
    let evenRowColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1.0)
    let oddRowColor: UIColor = .white
    
    
    @IBOutlet weak var spreadViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var schoolNameLbel: UILabel!
    
   
    
    lazy var leftBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
        CustomButton.customBarButton(btnBack: btnBack, title: "Back")

               btnBack.addTarget(self, action: #selector(backClicked(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()
    
    
    lazy var rightBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
        CustomButton.customBarButton(btnBack: btnBack, title: "Notification")

               btnBack.addTarget(self, action: #selector(notificationClicked(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadView.delegate = self
        spreadView.dataSource = self
        spreadView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))

        classesArray = MappedModel.converTestModel(tableInfoModel)
        customUi()
        
        
        ///check language :-
      /*  let preferredLanguage = NSLocale.preferredLanguages[0]


        if preferredLanguage == "en" {
            spreadView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } else if preferredLanguage == "ar" {
            spreadView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
       
        }
   */
        
      
        
    
        
       
    
     }


    
    
    func customUi(){
     
        spreadView.bounces = false
        spreadView.alwaysBounceVertical = false
        spreadView.alwaysBounceHorizontal = false
        spreadView.allowsMultipleSelection = false
        spreadView.allowsSelection = false
        spreadView.flashScrollIndicators()
    
        schoolNameLbel.text = tableInfoModel.school_name
        
        self.navigationItem.setLeftBarButtonItems(self.leftBarItem, animated: true)
        self.navigationItem.setRightBarButtonItems(self.rightBarItem, animated: true)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //spreadView.flashScrollIndicators()
        spreadView.bounces = false
        spreadView.flashScrollIndicators()
    
       
    }
    

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//           super.viewWillTransition(to: size, with: coordinator)
//           if UIDevice.current.orientation.isLandscape {
//               print("Landscape")
//           // spreadViewHeight.constant = 280
//
//
//           } else {
//               print("Portrait")
//
//            spreadViewHeight.constant = 400
//           }
//       }
//
    
    
    @objc func backClicked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
   
    
 
    @objc func notificationClicked(_ sender: Any){
     
        /// notification
        
    }
   
    
}


