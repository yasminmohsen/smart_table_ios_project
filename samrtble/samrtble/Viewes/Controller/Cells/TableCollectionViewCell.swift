//
//  TableCollectionViewCell.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 13/04/2021.
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    
    var alertAction :((_ msg:String)->Void)?
    var alertTimeAction :((_ msgTime:String)->Void)?
    var confirmWaitingClassAction :((_ link:String)->Void)?
    var msg = ""
    var confirmLink: String? = ""
    var msgTime = ""
    let from = "From".localized
    let to = "To".localized
    func customCell (text:String,isWaiting:Bool,confirmLink:String?,wcPriority:String?,confirmed:Bool?,showTime:Bool,classModel:ClassModel?){
        
        self.label.lineBreakMode = .byWordWrapping
        self.label.numberOfLines = 0
        self.label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        self.label.textAlignment = .center
        self.label.textColor = UIColor.black
        if wcPriority == nil {
            self.label.text = text
        } else {
            self.label.text = wcPriority
        }
        msg = text
        self.confirmLink = confirmLink
        
        if(isWaiting){
            
            self.backgroundColor = Colors.getColor(type: .customOrangeCell)[0]
            self.layer.cornerRadius = 6
             self.clipsToBounds = false
            if wcPriority == nil {
                self.label.text = "-"
            } else {
                self.label.text = wcPriority
            }

            if wcPriority == nil || confirmed == true {
                let geastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(popUpAlert))
                self.addGestureRecognizer(geastureRecognizer)
            }


            
        }
        else{
            
            self.backgroundColor = .clear
            
        }
        
        if wcPriority != nil {
            if confirmed == true {
                self.backgroundColor = Colors.getColor(type: .teal)[0]
            } else {
                let geastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(confirmWaitingClass))
                self.addGestureRecognizer(geastureRecognizer)
            }
        }
        
        
        if(showTime){
            
            if let classModel = classModel{
                
                msgTime = " \(from) :  \(classModel.start_time )\r \(to) :  \(classModel.end_time )"
                let geastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(popUpTimeAlert))
                self.addGestureRecognizer(geastureRecognizer)
                
            }
            
            
            
        }
        
        
        
    }
    
    
    @objc func popUpAlert(){
        
        
        if let alertAction = alertAction{
            
            
            alertAction(msg)
        }
        
        
        
    }
    
    
    @objc func confirmWaitingClass(){
        if let confirmWaitingClassAction = confirmWaitingClassAction{
            guard let link = confirmLink else { return }
            confirmWaitingClassAction(link)
        }
    }
    
    
    
    
    
    @objc func popUpTimeAlert(){
        
        
        if let alertTimeAction = alertTimeAction{
            
            
            alertTimeAction(msgTime)
        }
        
        
        
    }
    
    
}
