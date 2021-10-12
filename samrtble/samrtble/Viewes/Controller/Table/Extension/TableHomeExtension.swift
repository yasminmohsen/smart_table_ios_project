//
//  TableHomeExtension.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 13/04/2021.
//

import Foundation
import UIKit

extension TableHomeViewController :UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if(tableInfoModel.count>0){
            return tableInfoModel[0].classes.count
        }
        else{
            return 1
        }
        
//        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableCollectionViewCell
        if (subjectsArray.count > 0){

              switch collectionView {
              case sunday:
                if(checkColoredItem() == .coloredSunday){
                    changeColor(collectionView: sunday, change: true)
                }
                else {
                    changeColor(collectionView: sunday, change: false)
                }
                cell.customCell(text: subjectsArray[indexPath.column][indexPath.row])
                
              case monday:
                if(checkColoredItem() == .coloredMonday){
                    changeColor(collectionView: monday, change: true)
                }
                else {
                    changeColor(collectionView: monday, change: false)
                }
             
                cell.customCell(text: subjectsArray[indexPath.column+1][indexPath.row])
                
              case tuesday:
                if(checkColoredItem() == .coloredTuesday){
                changeColor(collectionView: tuesday, change: true)
            }
            else {
                changeColor(collectionView: tuesday, change: false)
            }
             
                  cell.customCell(text: subjectsArray[indexPath.column+2][indexPath.row])
              case wednsday:
                if(checkColoredItem() == .coloredWednsday){
            changeColor(collectionView: wednsday, change: true)
        }
        else {
            changeColor(collectionView: wednsday, change: false)
        }
                  cell.customCell(text: subjectsArray[indexPath.column+3][indexPath.row])
              case thuresday:

                if(checkColoredItem() == .coloredThursday){
                    changeColor(collectionView: thuresday, change: true)
                }
                else {
                    changeColor(collectionView: thuresday, change: false)
                }
                  cell.customCell(text: subjectsArray[indexPath.column+4][indexPath.row])
              case classesNumberView:
                cell.customCell(text: "\(classNumberArray[indexPath.row].number)") 
              default:
                  break
              }
           
        }
        
        return cell
        
}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        
        var heightSize :Int = 0
        if tableInfoModel.count > 0{
            
            if tableInfoModel[0].classes.count > 0 {
                
                heightSize = 600 / tableInfoModel[0].classes.count
             
                
            }
            
        }
        if(collectionView == classesNumberView){
          
           
            return CGSize(width: 30, height: heightSize)
        }
        else{

            return CGSize(width: 60, height: heightSize)
        }
        
          
        }
    
    
    
    func checkColoredItem() -> ColoredDay {
    
        if(daysArray != nil){
            for (index ,dayObj) in daysArray.enumerated() {
                
                if(dayObj == day){
                    switch index {
                    case 0:
                        return .coloredSunday
                    case 1:
                        return .coloredMonday
                    case 2:
                        return .coloredTuesday
                    case 3:
                        return .coloredWednsday
                    case 4:
                        return .coloredThursday
                    default:
                        break
                    }
                    
                }

            }
        }
        
       
        return .non
    }
    
    
    
    
    func changeColor(collectionView :UICollectionView ,change:Bool) {
        
        if(change == true){
            collectionView.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
        }
        else{
            collectionView.layer.backgroundColor = UIColor.white.cgColor
        }
        
    }
    
    
    
    
}
