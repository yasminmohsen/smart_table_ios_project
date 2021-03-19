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
    
    
    var myArr = [["1","2","3","4","5","6","7"],

                 ["8","9","10","11","12","13","14"],
                 ["15","16","17","18","19","20","21"],
                 ["21","23","24","25","26","27","28"],
                 ["29","30","31","32","33","34","35"]

    ]
    
    
    
    
    
    
    @IBOutlet weak var spreadViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadView.delegate = self
        spreadView.dataSource = self
        spreadView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))

        spreadView.bounces = false
        spreadView.alwaysBounceVertical = false
        spreadView.alwaysBounceHorizontal = false
        spreadView.allowsMultipleSelection = false
        spreadView.allowsSelection = false
        spreadView.flashScrollIndicators()
   
        
  
      
        
        
        tableInfoModel = TestModel.testModelObj()[0]
        
        classesArray = MappedModel.converTestModel(tableInfoModel)
        
        
        
//        customUi()
        // Do any additional setup after loading the view.
        
    
     }


    
    
    func customUi(){
     
        //  ui component custom
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //spreadView.flashScrollIndicators()
        spreadView.bounces = false
        spreadView.flashScrollIndicators()
    
       
    }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           super.viewWillTransition(to: size, with: coordinator)
           if UIDevice.current.orientation.isLandscape {
               print("Landscape")
            spreadViewHeight.constant = 280
         
             
           } else {
               print("Portrait")
            
            spreadViewHeight.constant = 400
           }
       }
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
    }
 
}


