//
//  HomeViewController.swift
//  smartble
//
//  Created by Yasmin Mohsen on 18/03/2021.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var logOutBtn: UIBarButtonItem!
    @IBOutlet weak var schoolTable: UITableView!
    
    @IBOutlet weak var notificationBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var teacherNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUi()

       
    }
    
    
    
    // MARK: Csutomization Ui:-
    func customUi(){
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.layoutIfNeeded()
        /// btn ui custom
        
    
    }
    
    
    
    // MARK: Button Action :-
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
        
        /// Notification Handle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //call api
        
        
    }
    
}


extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        cell.schoolNameBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cell.schoolNameBtn.tag = indexPath.row
       
    return cell
            
        
        
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
            let btnsendtag: UIButton = sender
         print(sender.tag)
        
        var vc = storyboard?.instantiateViewController(withIdentifier: "classTable")as! ClassesViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
        
            
        }
    
    
}
