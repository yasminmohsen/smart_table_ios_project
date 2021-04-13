//
//  CustomClassTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 13/04/2021.
//

import UIKit

class CustomClassTableViewController: UIViewController {
    @IBOutlet weak var classesNumber: UICollectionView!
    

    @IBOutlet weak var wendsday: UICollectionView!
    @IBOutlet weak var tuesday: UICollectionView!
    @IBOutlet weak var monday: UICollectionView!
    @IBOutlet weak var sunday: UICollectionView!
    
   // @IBOutlet var embededViewes: [UIView]!
    
    @IBOutlet weak var thursday: UICollectionView!
    var classNumberArray = [ClassModel]()
    var collectionArray:[UICollectionView]!
    
    var subjectsArray = [[String]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
     collectionArray = [classesNumber,sunday,monday,tuesday,wendsday,thursday]
        
        for i in collectionArray {
            
            
            i.delegate = self
            i.dataSource = self
            i.layer.backgroundColor = UIColor.white.cgColor
            CustomDesignView.customViewWithShadow(view: i)
            
        }
        
//        for v in embededViewes {
//
//            CustomDesignView.customViewWithShadow(view: v)
//
//        }
        
       
    }
    
    
    
    
    func updateUi(_ subjectArray :[[String]],_ classNumber :[ClassModel]){
        self.subjectsArray = subjectArray
        self.classNumberArray = classNumber
//        self.day = day
//        self.daysArray = daysArray
//        result = checkColoredItem()
        for obj in collectionArray{
            obj.reloadData()
        }
   
    }
    

  

}

extension CustomClassTableViewController :UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TableCollectionViewCell
        
        cell.label.lineBreakMode = .byWordWrapping
        cell.label.numberOfLines = 0
        cell.label.font = UIFont.systemFont(ofSize: 12)
        cell.label.textAlignment = .center
        switch collectionView {
        case sunday:
            cell.label.text = subjectsArray[indexPath.column][indexPath.row]
        case monday:
            cell.label.text = subjectsArray[indexPath.column+1][indexPath.row]
        case tuesday:
            cell.label.text = subjectsArray[indexPath.column+2][indexPath.row]
        case wendsday:
            cell.label.text = subjectsArray[indexPath.column+3][indexPath.row]
        case thursday:
            
            cell.label.text = subjectsArray[indexPath.column+4][indexPath.row]
        case classesNumber:
            cell.label.text = "\(classNumberArray[indexPath.row].number)"
        default:
            break
        }
        
        
        
        return cell
        
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        
        
        if(collectionView == classesNumber){
            return CGSize(width: 30.0, height: 50.0)
        }
        else{
            
            return CGSize(width: 50.0, height: 50.0)
        }
        
          
        }
    
    
    
    
    
    
    
    
}
