//
//  TableHomeViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 31/03/2021.
//

import UIKit
import SideMenu
class TableHomeViewController: UIViewController {
    

    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var connectedWith: UILabel!
    @IBOutlet var segmentedBtnView: [UIView]!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var schoolSegmentedBtn: UISegmentedControl!
    @IBOutlet weak var tabBarSegmentedBtn: UISegmentedControl!
    
    @IBOutlet weak var classesNumberView: UICollectionView!
    @IBOutlet weak var sunday: UICollectionView!
    @IBOutlet weak var monday: UICollectionView!
    @IBOutlet weak var tuesday: UICollectionView!
    @IBOutlet weak var wednsday: UICollectionView!
    @IBOutlet weak var thuresday: UICollectionView!
    @IBOutlet weak var segmentedBnHightConstarints: NSLayoutConstraint!
    
    var tableInfoModel : [TableInfoModel]!
    var classesArray = [[[String]]]()
    var homaViewModel = HomeViewModel()
    var mobilePhone :String!
    var apiKey :String?
    var classesNumber = [[ClassModel]]()
    var day :String!
    var daysArray = [String]()
    var schoolNames = [String]()
    let hi = "Hi,".localized
    let connected = "Connected with ".localized
    let school = "school".localized
    let teacherWord = "Teacher in".localized
    var classNumberArray = [ClassModel]()
    var subjectsArray = [[String]]()
    var collectionArray = [UICollectionView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionArray = [classesNumberView,sunday,monday,tuesday,wednsday,thuresday]
        customUi()
        bindingData()
       
        }
        

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        tabBarSegmentedBtn.selectedSegmentIndex = 1
        callApi()

    }
    
    
    // MARK:Functions :-
    
    func customUi(){
        CustomDesignView.customViewWithShadow(view: dayStackView)
        dayStackView.layer.borderColor = UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0).cgColor
        dayStackView.layer.borderWidth = 0.2
    
        schoolSegmentedBtn.setSegmentStyle()
        tabBarSegmentedBtn.setSegmentStyle()
        
        for segView in segmentedBtnView{
            CustomDesignView.customViewWithShadow(view: segView)
            segView.layer.borderColor =  UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0).cgColor
           
        }
        
        for i in collectionArray {
            
            i.delegate = self
            i.dataSource = self
            i.layer.backgroundColor = UIColor.white.cgColor
            CustomDesignView.customViewWithShadow(view: i)
            
        }
    }

    
   
    
    func updateUi(){
        teacher.text = teacherWord
        schoolNames = homaViewModel.schoolNames
        classesArray = homaViewModel.classesArray
        classesNumber=homaViewModel.classesNumber
        day = homaViewModel.day
        daysArray = homaViewModel.daysArray
        teacherName.text = "\(hi) \(homaViewModel.teacherName)"
        connectedWith.text = "\(schoolNames[0])"
        
        schoolSegmentedBtn.removeAllSegments()
        
        for (index,school) in schoolNames.enumerated()
       {
        
        schoolSegmentedBtn.insertSegment(withTitle: school, at: index, animated: false)
       }
        
        schoolSegmentedBtn.selectedSegmentIndex = 0
        self.updateTableInContainer(index: 0)
        
        if(schoolNames.count>1){
            
            schoolSegmentedBtn.alpha = 1
            segmentedBnHightConstarints.constant = 50
        }
     
    }
    
   
    
    func updateTableInContainer(index : Int){
        if(classesArray.count>0 && classesNumber.count>0){
            subjectsArray = classesArray[index]
            classNumberArray = classesNumber[index]}
        for collectionObj in collectionArray {
            
            collectionObj.reloadData()
        }
    
        
    }
    
    
    
    func callApi(){
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .start)
        
        let defaults = UserDefaults.standard
        mobilePhone = defaults.string(forKey: MainLoginViewController.PHONE_KEY)
        
        homaViewModel.fetchDataFromApi(phone: mobilePhone)
        
    }
    
    
    
    
    // MARK:Action Functions :-
    

    @IBAction func schoolSegmentAction(_ sender: Any) {
        
     let index = schoolSegmentedBtn.selectedSegmentIndex
        if(classesArray.count > 0){
            updateTableInContainer(index: index)
        }
       
    }
    
    
    
    
    @IBAction func tabBarAction(_ sender: Any) {
        print(tabBarSegmentedBtn.selectedSegmentIndex)
        
        switch tabBarSegmentedBtn.selectedSegmentIndex {
        case 0:
            let vc = self.storyboard?.instantiateViewController(identifier: "notificationVC") as! NotificationViewController

            self.navigationController?.pushViewController(vc, animated: true)
               
        default:
      break
 
        }
  
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
    
        CustomDesignView.customMenuShadowView(menu)
        
        present(menu, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func unwinToHome(segue: UIStoryboardSegue){
        
    }
      
    
   
    
    
    
    
    // MARK: Binding :-
    
    func bindingData(){
        
        
        homaViewModel.bindLogingModel = {
            (error:String? , data:[TableInfoModel]?, netWorkError:String?) ->() in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
            if let data = data {
                self.onSucessUpdateView()
            }
            
            
            if let error = error{
                self.onFiluer(error: error,netWorkError: nil)
                
            }
            
            if let netWorkError = netWorkError{
                self.onFiluer(error: nil, netWorkError: netWorkError)
            }
                
            }
         
        }
    }
    
    
    
    
    // MARK: After Binding Functions :-
    
    func onSucessUpdateView(){
        
         self.tableInfoModel = homaViewModel.data
         self.updateUi()
     ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
        
    }
    
    func onFiluer(error:String? ,netWorkError:String?){
        if let netWorkError = netWorkError {
            Alert.showSimpleAlert(title: "Alert", message: netWorkError, viewRef: self)
        
        }
        
        if let error = error {
            Alert.showSimpleAlert(title: "Alert", message: error, viewRef: self)
          
        }
        ActivityIndecatorBehaviour.activityIndecatorAction(activityIndecator: activityIndecator, status: .stop)
    
    }
    
}


