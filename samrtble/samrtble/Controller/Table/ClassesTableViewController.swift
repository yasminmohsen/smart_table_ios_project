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
    var daysArray = [String]()
    var day : String!
    var result :ColoredDay!
    
    
    
    
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
           
            case sunday:
                
                if(result == .coloredSunday){
                    CustomDesignView.customColoredSheet(sunday, cell)
                }
                cell.label.text = subjectsArray[indexPath.column][indexPath.row]
               
            case monday:
                if(result == .coloredMonday){

                    CustomDesignView.customColoredSheet(monday, cell)
                }
                
                cell.label.text = subjectsArray[indexPath.column + 1][indexPath.row]
            case tuesday:
                if(result == .coloredTuesday){
                    
                    CustomDesignView.customColoredSheet(tuesday, cell)
                }
                cell.label.text = subjectsArray[indexPath.column + 2][indexPath.row]
                
            case wednsday:
                if(result == .coloredWednsday){

                    CustomDesignView.customColoredSheet(wednsday, cell)
                }
                cell.label.text = subjectsArray[indexPath.column + 3][indexPath.row]
                
            case thursday:
                if(result == .coloredThursday){

                    CustomDesignView.customColoredSheet(thursday, cell)
                }
                cell.label.text = subjectsArray[indexPath.column + 4][indexPath.row]
                
            case classesView:
                cell.label.text = "\(classNumberArray[indexPath.row].number)"
               
                
            default:
                break
            }
                   
        }
       
        cell.label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return cell
    
    }
    
    
    
    func customUi(){
 
        for i in spreedSheetArray{
            i.delegate = self
            i.dataSource = self
            CustomDesignView.customSpreadSheetView(i)
           
            for v in embededViewCollection {
                
                CustomDesignView.customViewWithShadow(view: v)
              
            }
        }

    }
    
    
    
    func updateUi(_ subjectArray :[[String]],_ classNumber :[ClassModel],day:String,daysArray:[String]){
        self.subjectsArray = subjectArray
        self.classNumberArray = classNumber
        self.day = day
        self.daysArray = daysArray
        result = checkColoredItem()
        for obj in spreedSheetArray{
            obj.reloadData()
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
        
