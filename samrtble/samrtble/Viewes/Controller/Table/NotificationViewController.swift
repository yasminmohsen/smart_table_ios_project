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
    @IBOutlet weak var segemntedBtn: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedBtnView: UIView!
    var notificationTableResult = [ResultNotification]()
    let notificationViewModel = NotificationViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segemntedBtn.setSegmentStyle()
        CustomDesignView.customViewWithShadow(view: segmentedBtnView)
        segmentedBtnView.layer.borderColor =  UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0).cgColor
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .start)
        notificationViewModel.bindNotificationModel = { (error:String? , data:[ResultNotification]?,netWorkError:String?) ->() in
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                
                if let netWorkError = netWorkError {
                    
                    self.onFiluer(error: nil, netWorkError: netWorkError)
                }
                if let error = error {
                    
                    self.onFiluer(error: error, netWorkError: nil)
                }
                if let _ = data {
                    
                    self.onSucessUpdateView()
                    
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationViewModel.fetchDataFromApi()
    }
    
    @objc func refreshTable (){
        
        notificationViewModel.fetchDataFromApi()
        
    }
    
    @IBAction func segmentedBtnAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        if (sender.selectedSegmentIndex == 1 ){
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func onSucessUpdateView(){
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
        self.notificationTableResult.removeAll()
        self.notificationTableResult = notificationViewModel.data
        if(self.notificationTableResult.count > 0){
            self.noNotificationView.alpha = 0
        }
        else{
            self.noNotificationView.alpha = 1
        }
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    func onFiluer(error:String? ,netWorkError:String?){
        if let netWorkError = netWorkError {
            Alert.showSimpleAlert(title: "Alert", message: netWorkError, viewRef: self)
        }
        
        if let error = error {
            Alert.showSimpleAlert(title: "Alert", message: error, viewRef: self)
        }
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
        self.refreshControl.endRefreshing()
        
    }
}




