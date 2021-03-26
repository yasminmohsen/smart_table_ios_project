//
//  ClassesViewController extension.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import Foundation
import SpreadsheetView
import UIKit


extension ClassesViewController : SpreadsheetViewDelegate,SpreadsheetViewDataSource{
  
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
            return 50
        }

        func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
            if case 0 = row {
                return 80
            } else {
                return 80
                
            }
        }
    
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
       8
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
     6
    }
    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case 0 = indexPath.row{
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
          
            if (indexPath.column == 0){
                
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
          
                cell.label.text = "Day/class".localized
        
           customCellLang(cell: cell)
              
               
                
                return cell
            }
            else{
               
                var number = (tableInfoModel.classes[indexPath.column - 1 ].number)
                var startTime = (tableInfoModel.classes[indexPath.column - 1 ].start_time)
                var endTime = (tableInfoModel.classes[indexPath.column - 1 ].end_time)
                
                
                cell.label.text = "\(number)\n\(startTime)-\(endTime)"
               
                
                
            }
           

                cell.setNeedsLayout()
           // cell.contentView.layer.borderColor = UIColor.black.cgColor;
            // cell.contentView.layer.borderWidth = 3.0;
           
            
            
            customCellLang(cell: cell)

          
                return cell
            }
        
        if case 0 =  indexPath.column {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
             
           cell.label.text = tableInfoModel.days[indexPath.row-1]
            //cell.label.backgroundColor = indexPath.row % 2 == 0 ? evenRowColor : evenRowColor
            cell.setNeedsLayout()
           
            customCellLang(cell: cell)
       

            return cell
        }
        
        else {
               
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            if(classesArray[indexPath.row - 1][indexPath.column-1] == "----"){
                cell.label.text = classesArray[indexPath.row - 1][indexPath.column-1]
                cell.label.textColor = .gray
            }
            else{
                cell.label.text = classesArray[indexPath.row - 1][indexPath.column-1]
                cell.label.textColor = .black
            }
          
//            cell.color = indexPath.row % 2 == 0 ? .blue : .blue
            
            customCellLang(cell: cell)

                return cell
            }
        }
    
    
    
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
          return 1
      }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    
    
    
    
    
    /// Delegate
  
    
 
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
           if case 0 = indexPath.row {
               if sortedColumn.column == indexPath.column {
                   sortedColumn.sorting = sortedColumn.sorting == .ascending ? .descending : .ascending
               } else {
                   sortedColumn = (indexPath.column, .ascending)
               }
               
           }
       }
}
enum Sorting {
      case ascending
      case descending

  }
