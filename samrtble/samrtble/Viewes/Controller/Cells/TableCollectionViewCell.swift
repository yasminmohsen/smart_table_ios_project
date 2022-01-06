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
    var msg = ""
    var msgTime = ""
    let from = "From".localized
    let to = "To".localized
    func customCell (text:String,isWaiting:Bool,showTime:Bool,classModel:ClassModel?){
        
        self.label.lineBreakMode = .byWordWrapping
        self.label.numberOfLines = 0
        self.label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        self.label.textAlignment = .center
        self.label.textColor = UIColor.black
        self.label.text = text
        msg = text
        
        
        if(isWaiting){
            
            self.backgroundColor = Colors.getColor(type: .customOrangeCell)[0]
            self.layer.cornerRadius = 6
             self.clipsToBounds = false
            self.label.text = "-"
            
            let geastureRecognizer = UITapGestureRecognizer(target: self, action: #selector(popUpAlert))
            self.addGestureRecognizer(geastureRecognizer)
            
            
        }
        else{
            
            self.backgroundColor = .clear
            
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
    
    
    
    
    
    @objc func popUpTimeAlert(){
        
        
        if let alertTimeAction = alertTimeAction{
            
            
            alertTimeAction(msgTime)
        }
        
        
        
    }
    
    
}
