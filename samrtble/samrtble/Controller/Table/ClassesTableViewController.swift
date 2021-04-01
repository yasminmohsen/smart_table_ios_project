//
//  ClassesTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/03/2021.
//

import UIKit
import SpreadsheetView
class ClassesTableViewController: UIViewController , SpreadsheetViewDelegate ,SpreadsheetViewDataSource {
  
   
    @IBOutlet var embededViewCollection: [UIView]!
    @IBOutlet weak var thursday: SpreadsheetView!
    @IBOutlet weak var wednsday: SpreadsheetView!
    @IBOutlet weak var tuesday: SpreadsheetView!
    @IBOutlet weak var monday: SpreadsheetView!
    @IBOutlet weak var classesView: SpreadsheetView!
    @IBOutlet weak var sunday: SpreadsheetView!
    var subjectsArray = [[String]]()
    var spreedSheetArray : [SpreadsheetView]!
    var classNumberArray = [ClassModel]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        spreedSheetArray = [classesView,monday,tuesday,wednsday,thursday,sunday]
        customUi()
    }

    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
      
        if(spreadsheetView == classesView){
            return 30
        }
        else{
          
            return 55
        }        }

        func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
          
          
           return ((spreadsheetView.frame.height / 7))
        
        }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
      
        return 1
                
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
      
        return 7

    }
    

    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
      
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TableCell.self), for: indexPath) as! TableCell
            
      
        if(subjectsArray .count > 0){
            switch spreadsheetView {
            case thursday:
            
                cell.label.text = subjectsArray[indexPath.column + 4][indexPath.row]
               
            case sunday:
                
                cell.label.text = subjectsArray[indexPath.column][indexPath.row]
                sunday.gridStyle = .solid(width:2, color: Colors.getColor(type: .customBej)[0])
                sunday.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
                cell.label.layer.backgroundColor = Colors.getColor(type: .customBej)[0].cgColor
            case monday:
                
                cell.label.text = subjectsArray[indexPath.column + 1][indexPath.row]
            case tuesday:
                
                cell.label.text = subjectsArray[indexPath.column + 2][indexPath.row]
            case wednsday:
                
                cell.label.text = subjectsArray[indexPath.column + 3][indexPath.row]
                
            case classesView:
                cell.label.text = "\(classNumberArray[indexPath.row].number)"
               
                
            default:
                break
            }
              //  cell.label.text = "hello table"
                   
        }
       
        cell.label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return cell
    
    }
    
    
    
    func customUi(){
        
       
        for i in spreedSheetArray{
            i.register(TableCell.self, forCellWithReuseIdentifier: String(describing: TableCell.self))
            i.delegate = self
            i.dataSource = self

            i.bounces = false
            i.isScrollEnabled = false
            i.layer.masksToBounds = false
            i.backgroundView?.layer.cornerRadius = 12
            i.clipsToBounds = true
            i.layer.cornerRadius = 12
            i.gridStyle = .none
            
            for v in embededViewCollection {
                
                CustomButton.customViewWithShadow(view: v)
              
            }
           
        }

    }
    
    
    
    func updateUi(_ subjectArray :[[String]],_ classNumber :[ClassModel]){
        self.subjectsArray = subjectArray
        self.classNumberArray = classNumber
    
        for obj in spreedSheetArray{
            obj.reloadData()
        }
        
        
    }
    
    
}
        
