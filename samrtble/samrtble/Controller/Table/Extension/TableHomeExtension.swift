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
        
        return 7
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableCollectionViewCell
        if (subjectsArray.count > 0){

              switch collectionView {
              case sunday:
                if(checkColoredItem() == .coloredSunday){
                    sunday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
                }
                cell.customCell(text: subjectsArray[indexPath.column][indexPath.row])
                
              case monday:
                if(checkColoredItem() == .coloredMonday){
                    monday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
                }
             
                cell.customCell(text: subjectsArray[indexPath.column+1][indexPath.row])
                
              case tuesday:
                if(checkColoredItem() == .coloredTuesday){
                    tuesday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
                }
             
                  cell.customCell(text: subjectsArray[indexPath.column+2][indexPath.row])
              case wednsday:
                if(checkColoredItem() == .coloredWednsday){
                    wednsday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
                }
                  cell.customCell(text: subjectsArray[indexPath.column+3][indexPath.row])
              case thuresday:
                if(checkColoredItem() == .coloredThursday){
                    thuresday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
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
        
        
        if(collectionView == classesNumberView){
            return CGSize(width: 30.0, height: 55.0)
        }
        else{
            
            return CGSize(width: 55.0, height: 55.0)
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
    
    
    
    
    
    
    
    
}
