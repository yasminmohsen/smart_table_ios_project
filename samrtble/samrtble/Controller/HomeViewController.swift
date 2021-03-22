//
//  HomeViewController.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var logOutBtn: UIBarButtonItem!
    @IBOutlet weak var schoolTable: UITableView!
    
   // @IBOutlet weak var notificationBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    var tableInfoModel : [TableInfoModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUi()
       schoolTable.delegate = self
       
    }
    
    lazy var leftBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
        CustomButton.customBarButton(btnBack: btnBack, title: "Logout")

               btnBack.addTarget(self, action: #selector(logOutClicked(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()

    
    lazy var righttBarItem: Array = { () -> [UIBarButtonItem] in
               let btnBack = UIButton(type: .custom)
        CustomButton.customBarButton(btnBack: btnBack, title: "Notification")

               btnBack.addTarget(self, action: #selector(notificationClicked(_:)), for: .touchUpInside)
               let item = UIBarButtonItem(customView: btnBack)
               item.tag = 3
               return [item]
       }()
    
    // MARK: Csutomization Ui:-
    func customUi(){
        
        
        
        self.navigationItem.setLeftBarButtonItems(self.leftBarItem, animated: true)
        self.navigationItem.setRightBarButtonItems(self.righttBarItem, animated: true)
        
        
        for obj in tableInfoModel {
            
            teacherNameLabel.text = obj.teacher_nickname
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //call api
        
    
        
    }
    
    // MARK: Button Action :-
    
   
    @objc func logOutClicked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationClicked(_ sender: Any){
       
    }
    
 
    
}


extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInfoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.schoolNameBtn.setTitle("\(tableInfoModel[indexPath.row].school_name)", for: .normal) 
        cell.schoolNameBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.schoolNameBtn.tag = indexPath.row
        
        cell.schoolNameBtn.titleLabel?.numberOfLines=0
        cell.schoolNameBtn.titleLabel?.lineBreakMode = .byWordWrapping
       
       
    return cell
            
        
        
    }
    
    
   
    @objc func buttonAction(sender: UIButton!) {
            let btnsendtag: UIButton = sender
         print(sender.tag)
        
        var vc = storyboard?.instantiateViewController(withIdentifier: "classTable")as! ClassesViewController
        vc.tableInfoModel = tableInfoModel[sender.tag]
        navigationController?.pushViewController(vc, animated: true)
        
        
            
        }
    
    
  
    
}
