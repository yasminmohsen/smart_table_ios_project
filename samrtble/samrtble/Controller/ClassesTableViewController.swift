//
//  ClassesTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/03/2021.
//

import UIKit
import SpreadsheetView
class ClassesTableViewController: UIViewController , SpreadsheetViewDelegate ,SpreadsheetViewDataSource {

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if(spreadsheetView == classesView){
            return( (spreadsheetView.frame.width / 6) - 1 )
        }
        else{
            return( (classesView.frame.width / 6) - 1 )
        }        }

        func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
          
            if(spreadsheetView == classesView){
                return 50
            }
            
            else{
                return ((spreadsheetView.frame.height / 7))
            }

        }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        if(spreadsheetView == classesView){
            return 6
        }
        
        else{
            return 1
        }
                
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        if(spreadsheetView == classesView){
            return 1
        }
        
        else{
            return 7
        }

    }
    
    
    
    
    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
      
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TableCell.self), for: indexPath) as! TableCell
            
        
        var days = ["sunday","monday","tuesday","wednsday","thursday"]
        var classe = ["1","2","3","4","5","6","7"]
        var sub = [["english","tawheed\nف-٩٨","---","quraan","---","english","---"],
                   ["---","quraan","---","english","---","arabic","---"],
                   ["---","---","---","quraan","---","english","---"],
                   ["tawhed","---","---","quraan\nف-٣١","---","---","tawhed"],
                   ["---","---","---","quraan","---","english","---"]]
        
        
      
        if(spreadsheetView == classesView) {
            
            if(indexPath.column == 0){
                
                cell.label.text = "day"
            }
            else{
                cell.label.text = days[indexPath.column - 1]
            }
            
            cell.label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            cell.label.textColor = UIColor(red: 40/255, green: 211/255, blue: 183/255, alpha: 1.0)
            
           
            
        }
        
        
        switch spreadsheetView {
        case dayView:
        
            cell.label.text = sub[indexPath.column + 4][indexPath.row]
           
        case sunday:
            
            cell.label.text = sub[indexPath.column][indexPath.row]
        case monday:
            
            cell.label.text = sub[indexPath.column + 1][indexPath.row]
        case tuesday:
            
            cell.label.text = sub[indexPath.column + 2][indexPath.row]
        case wednsday:
            
            cell.label.text = sub[indexPath.column + 3][indexPath.row]
            
        case thursday:
            cell.label.text = classe[indexPath.row]
           
            
        default:
            break
        }
          //  cell.label.text = "hello table"
               
        cell.label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
                return cell
            
    
    }
    @IBOutlet weak var thursday: SpreadsheetView!
    @IBOutlet weak var wednsday: SpreadsheetView!
    @IBOutlet weak var tuesday: SpreadsheetView!
    @IBOutlet weak var monday: SpreadsheetView!
    @IBOutlet weak var dayView: SpreadsheetView!
    @IBOutlet weak var classesView: SpreadsheetView!
    @IBOutlet weak var sunday: SpreadsheetView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classesView.dataSource = self
        dayView.delegate = self
        dayView.dataSource = self
        monday.delegate = self
        monday.dataSource = self
        tuesday.delegate = self
        tuesday.dataSource = self
        wednsday.delegate = self
        wednsday.dataSource = self
        thursday.delegate = self
        thursday.dataSource = self
        sunday.delegate = self
        sunday.dataSource = self
        
        let arry = [classesView,dayView,monday,tuesday,wednsday,thursday,sunday]
        
       
        for i in arry{
            i!.register(TableCell.self, forCellWithReuseIdentifier: String(describing: TableCell.self))
            i?.gridStyle = .none
            if(i==classesView){
                i?.gridStyle = .solid(width: 1, color: .white)
            }
            i?.bounces = false
            i?.isScrollEnabled = false
            i?.layer.borderWidth = 0.5
            i?.layer.cornerRadius = 15
            i?.layer.borderColor = UIColor.white.cgColor
            i?.backgroundView?.layer.borderColor = UIColor.white.cgColor
            i?.layer.masksToBounds = true
    
        }
        
      
        
    }

    @IBOutlet weak var helloLabel: UILabel!
    
}


        class TableCell: Cell {
            let label = UILabel()
               var color: UIColor = .clear {
                   didSet {
                       backgroundView?.backgroundColor = color
                   }
               }

               override var frame: CGRect {
                   didSet {
                       label.frame = bounds.insetBy(dx: 0, dy: 0)
                  
                    
                    
                   }
               }

               override init(frame: CGRect) {
                   super.init(frame: frame)

                   backgroundView = UIView()

                   label.frame = bounds
                   label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                label.font = UIFont.systemFont(ofSize: 10)
                label.textAlignment = .center
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                backgroundView!.layer.backgroundColor = UIColor.white.cgColor
                label.textColor = UIColor.black
                backgroundView?.layer.cornerRadius = 15
                contentView.addSubview(label)
                
               }

               required init?(coder aDecoder: NSCoder) {
                   super.init(coder: aDecoder)
               }
        }
