//
//  CustomClassViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 13/04/2021.
//

import UIKit

class CustomClassViewController: UIViewController {

    var classNumberObj = [ClassModel]()
    var classArrayObj = [[String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CVC = children.last as! CustomClassTableViewController
        CVC.updateUi(classArrayObj,classNumberObj)
        navigationController?.navigationBar.isHidden = false
      
    }
    

  

    @IBAction func back(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}
