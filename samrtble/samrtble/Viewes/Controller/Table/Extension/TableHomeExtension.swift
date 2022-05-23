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
        
        let classInfo = "Class info :".localized
        let classTime = "Class Time".localized
        
        cell.alertAction = { msg in
            
            
            Alert.showSimpleAlert(title: "Waiting class", message: "\(classInfo) \r \(msg)", viewRef: self)
            
        }
        
        
        cell.alertTimeAction = { msg in
            
            
            Alert.showSimpleAlert(title: "Class Time", message: "\(msg)", viewRef: self)
            
        }
        
        cell.confirmWaitingClassAction = { [self] link in
            ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: self.activityIndecator, status: .start)
            self.homaViewModel.confirmWaitingClass(link: link)
        }
        
        
        
        if (subjectsArray.count > 0){

              switch collectionView {
              case sunday:
                
                checkChangingColor(coloredDay:.coloredSunday, collectionView:sunday)
                cell.customCell(text: subjectsArray[indexPath.column][indexPath.row].0,
                                isWaiting: subjectsArray[indexPath.column][indexPath.row].1,
                                confirmLink: subjectsArray[indexPath.column][indexPath.row].2,
                                wcPriority: subjectsArray[indexPath.column][indexPath.row].3,
                                confirmed: subjectsArray[indexPath.column][indexPath.row].4,showTime: false, classModel: nil)
                
              case monday:

                checkChangingColor(coloredDay:.coloredMonday, collectionView:monday)
                cell.customCell(text: subjectsArray[indexPath.column+1][indexPath.row].0,
                                isWaiting: subjectsArray[indexPath.column+1][indexPath.row].1,
                                confirmLink: subjectsArray[indexPath.column+1][indexPath.row].2,
                                wcPriority: subjectsArray[indexPath.column+1][indexPath.row].3,
                                confirmed: subjectsArray[indexPath.column+1][indexPath.row].4,showTime: false, classModel: nil)
                
              case tuesday:

             checkChangingColor(coloredDay:.coloredTuesday, collectionView:tuesday)
                cell.customCell(text: subjectsArray[indexPath.column+2][indexPath.row].0,
                                isWaiting: subjectsArray[indexPath.column+2][indexPath.row].1,
                                confirmLink: subjectsArray[indexPath.column+2][indexPath.row].2,
                                wcPriority: subjectsArray[indexPath.column+2][indexPath.row].3,
                                confirmed: subjectsArray[indexPath.column+2][indexPath.row].4,showTime: false, classModel: nil)
                
              case wednsday:
                
             checkChangingColor(coloredDay:.coloredWednsday, collectionView:wednsday)
                cell.customCell(text: subjectsArray[indexPath.column+3][indexPath.row].0,
                                isWaiting: subjectsArray[indexPath.column+3][indexPath.row].1,
                                confirmLink: subjectsArray[indexPath.column+3][indexPath.row].2,
                                wcPriority: subjectsArray[indexPath.column+3][indexPath.row].3,
                                confirmed: subjectsArray[indexPath.column+3][indexPath.row].4,showTime: false, classModel: nil)
                
              case thuresday:

                checkChangingColor(coloredDay:.coloredThursday, collectionView:thuresday)
                cell.customCell(text: subjectsArray[indexPath.column+4][indexPath.row].0,
                                isWaiting: subjectsArray[indexPath.column+4][indexPath.row].1,
                                confirmLink: subjectsArray[indexPath.column+4][indexPath.row].2,
                                wcPriority: subjectsArray[indexPath.column+4][indexPath.row].3,
                                confirmed: subjectsArray[indexPath.column+4][indexPath.row].4,showTime: false, classModel: nil)
                
              case classesNumberView:
                
                  cell.customCell(text: "\(classNumberArray[indexPath.row].number)", isWaiting: false,confirmLink:nil,wcPriority:nil,confirmed:nil,showTime: true, classModel: classNumberArray[indexPath.row])
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
    
    
    
    
    func checkChangingColor(coloredDay:ColoredDay, collectionView:UICollectionView){
        if(checkColoredItem() == coloredDay){
            changeColor(collectionView: collectionView, change: true)
        }
        else {
            changeColor(collectionView: collectionView, change: false)
        }
    }
    
    
    
    
}
