//
//  NotificationViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 31/03/2021.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var noNotificationView: UIView!
    
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var notificationTableResult = [ResultNotification]()
    let notificationViewModel = NotificationViewModel()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)

        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        activityIndecator.alpha = 1
        activityIndecator.startAnimating()
       
        
        notificationViewModel.bindNotificationModel = { (error:String? , data:[ResultNotification]?) ->() in
            
            
            DispatchQueue.main.async {[weak self] in
                
                guard let self = self else {return}
                
                if let error = error {
                    
                    
                    print(error)
                    self.activityIndecator.startAnimating()
                }
                
                if let data = data {
                    self.notificationTableResult.removeAll()
                    self.activityIndecator.stopAnimating()
                    self.activityIndecator.alpha = 0
                    self.notificationTableResult = data
                    if(self.notificationTableResult.count == 0){
                        self.noNotificationView.alpha = 1
                        
                    }
                    else{
                        self.noNotificationView.alpha = 0
                    }
                    refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    
                  
                    
                }
            }

            
        }
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        notificationViewModel.fetchData()
    }
    
    
    @objc func refreshTable (){
        
        notificationViewModel.fetchData()
     
    }
    
   
    @IBAction func segmentedBtnAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        if (sender.selectedSegmentIndex == 1 ){
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}


extension NotificationViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return notificationTableResult[section].data.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificationTableViewCell
        cell.languageCustomUi(cell: cell)
        cell.schoolLabel.text = notificationTableResult[indexPath.section].data[indexPath.row].title
        cell.detailsLabel.text = notificationTableResult[indexPath.section].data[indexPath.row].body
       
        cell.timeLabel.text = notificationTableResult[indexPath.section].data[indexPath.row].timeCreated
        CustomButton.customViewWithShadow(view: cell.viewCell)
        if(indexPath.section == 0 && indexPath.row == 0){
            //255 253 207
            cell.viewCell.layer.backgroundColor = UIColor(red: 255/255, green: 253/255, blue: 207/255, alpha: 1.0).cgColor
        }
        else{
            cell.viewCell.layer.backgroundColor = UIColor.white.cgColor
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130


    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notificationTableResult.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  notificationTableResult[section].date
    }


    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name:"Myriad Pro Bold", size: 16)
    }

    
}
