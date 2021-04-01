//
//  TableHomeViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 31/03/2021.
//

import UIKit
import SideMenu
class TableHomeViewController: UIViewController {
    
    
    @IBOutlet weak var teacherName: UILabel!
    
    @IBOutlet weak var connectedWith: UILabel!
    
    @IBOutlet var segmentedBtnView: [UIView]!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var schoolSegmentedBtn: UISegmentedControl!
    @IBOutlet weak var tabBarSegmentedBtn: UISegmentedControl!
    
    var tableInfoModel : [TableInfoModel]!
    var classesArray = [[[String]]]()
    var loginViewModel = LoginViewModel()
    var mobilePhone :String!
    var apiKey :String?
    var classesNumber = [[ClassModel]]()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUi()
      
            
        bindingData()
        
        if(tableInfoModel == nil){
            callApi()
        }
     
            
        }
        
    
    func customUi(){
        CustomButton.customViewWithShadow(view: dayStackView)
        dayStackView.layer.borderColor =  UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0).cgColor
        dayStackView.layer.borderWidth = 0.2
        dayStackView.layer.cornerRadius = 12
    
        schoolSegmentedBtn.setSegmentStyle()
        tabBarSegmentedBtn.setSegmentStyle()
        
        
        for segView in segmentedBtnView{
            CustomButton.customViewWithShadow(view: segView)
            segView.layer.borderColor =  UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0).cgColor
            segView.layer.cornerRadius = 12
        }
    }

    @IBAction func schoolSegmentAction(_ sender: Any) {
        
     let index = schoolSegmentedBtn.selectedSegmentIndex
        if(tableInfoModel != nil){
            updateTableInContainer(index: index)
        }
       
    }
    
    @IBAction func tabBarAction(_ sender: Any) {
        
        switch tabBarSegmentedBtn.selectedSegmentIndex {
        case 0:
            let vc = self.storyboard?.instantiateViewController(identifier: "notificationVC") as! NotificationViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
   
        default:
      break
 
        }
  
    }
    
    
    
    
    func updateUi(){
        var schoolNames = [String]()
        let hi = "Hi".localized
        let connected = "Connected with ".localized
        let school = "school".localized
        
        for obj in tableInfoModel {
          
            teacherName.text =  "\(hi) \(obj.teacher_nickname)"
            var MappingModel = MappedModel()
            schoolNames.append(obj.school_name)
            classesArray.append(MappingModel.converTableModelToClasses(obj))
            classesNumber.append(obj.classes)
            
        }
        schoolSegmentedBtn.removeAllSegments()
        for (index,school) in schoolNames.enumerated()
       {
        
        schoolSegmentedBtn.insertSegment(withTitle: school, at: index, animated: false)
       }
        
        schoolSegmentedBtn.selectedSegmentIndex = 0
        
        connectedWith.text = "\(connected)\(schoolNames.count)\(school)"
        
    }
    
    
    
    func updateTableInContainer(index : Int){
        
        
        let classArrayObj = classesArray[index]
        let classNumberObj = classesNumber[index]
        let CVC = children.last as! ClassesTableViewController
        CVC.updateUi(classArrayObj,classNumberObj)
        
    }
    

    func bindingData(){
        
        
        loginViewModel.bindLogingModel = {
            (error:String? , data:[TableInfoModel]?) ->() in
            
            DispatchQueue.main.async {
                if let error = error {
                   // alert
                    print(error)
                    
                }
                
                
                if let data = data {
                    
                    //Save Phone to UserDefault :-
                    
                   self.tableInfoModel = data
                    self.updateUi()
                    self.updateTableInContainer(index: 0)
                    
                }
                
            }
        }
    }
    
    
    
    
    func callApi(){
        let defaults = UserDefaults.standard
        mobilePhone = defaults.string(forKey: MainLoginViewController.PHONE_KEY)
        //mobilePhone = "00201017670053"
        
            loginViewModel.login(phone: mobilePhone, key: apiKey)
        
    }
    
    
    @IBAction func minueAction(_ sender: Any) {
        
       let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
     
        
      let language = LanguageOperation.checkLanguage()
        print(language)
        switch language {
        case .arabic:
            menu.leftSide = false
        case .english :
            menu.leftSide = true
        
        default:
            break
        }
        
        menu.presentationStyle = .menuSlideIn
        menu.view.layer.shadowColor =  UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.5).cgColor
        menu.view.layer.shadowOffset = CGSize(width: 3.0, height:3.0)
        menu.view.layer.shadowOpacity = 1.0
        menu.view.layer.shadowRadius = 3.0
        menu.view.layer.borderWidth = 0.2
        menu.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0 ,alpha: 0.16).cgColor
        
        present(menu, animated: true, completion: nil)
        
        
    }
    
}


