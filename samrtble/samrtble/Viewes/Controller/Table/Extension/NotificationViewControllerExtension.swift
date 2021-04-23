//
//  NotificationViewControllerExtension.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/04/2021.
//

import Foundation
import UIKit

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
        header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }

    
}
