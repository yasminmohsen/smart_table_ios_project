//
//  MenueTableTableViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 01/04/2021.
//

import UIKit
import MOLH
var logoutClicked = false
class MenueTableTableViewController: UITableViewController {
    
    @IBOutlet weak var contactUs: UIButton!
    
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logoutClicked = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactUs.titleLabel?.textAlignment = .center
        
        deleteAccountButton.setTitle("Delete Account".localized, for: .normal)
    }
    
    @IBAction func aboutAppBtn(_ sender: Any) {}
    @IBAction func contactUsBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "contactUsVc") as! ContactUsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapDeleteAccountButton(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            Alert.showAdvanceedAlert(title: "Alert".localized, message: "Do you want to Delete your account!?".localized, viewRef: self) { [weak self] in
                guard let self else { return }
                self.deleteAccount()
            }
        }
    }
    
    private func deleteAccount() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let success =  try await NetworkManager.deleteAccount(appService: .deleteAccount)
                if success {
                    logoutClicked = true
                    self.dismiss(animated: false)
                }
            } catch NetworkError.withMessage(let message) {
                Alert.showSimpleAlert(title: "Alert".localized, message: message, viewRef: self)
            } catch (let error) {
                print(error)
                Alert.showSimpleAlert(title: "Alert".localized, message: error.localizedDescription, viewRef: self)
            }
        }
    }
    @IBAction func rateUsBtn(_ sender: Any) {
        let appId = "1565596183"
        //itms-apps://apple.com/app/\(appId)
        if let url = URL(string: "http://itunes.apple.com/app/\(appId)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func languageBtn(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        restartApplication()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            Alert.showAdvanceedAlert(title: "Alert", message: "Do you want to log out ?", viewRef: self) { [weak self] in
                guard let self else { return }
                DispatchQueue.main.async {  [weak self] in
                    guard let self else { return }
                    logoutClicked = true
                    self.dismiss(animated: false)
                }
            }
        }
    }
    
    func restartApplication () {
        let launchScreen = UIStoryboard(name: "Main", bundle: nil)
        var tableViewController = launchScreen.instantiateViewController(withIdentifier: "splashScreen") as! SplashViewController
        let navCtrl = UINavigationController(rootViewController:tableViewController)
        //
        guard
            let window = UIApplication.shared.keyWindow,
            let rootViewController = window.rootViewController
        else {
            return
        }
        navCtrl.setNavigationBarHidden(true, animated: true)
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = navCtrl
        })
        
    }
}
