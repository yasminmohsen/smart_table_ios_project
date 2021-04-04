//
//  AppDelegate.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 19/03/2021.
//

import UIKit
import MOLH
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   
        
        if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self

              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
            }

            application.registerForRemoteNotifications()
      print(application.isRegisteredForRemoteNotifications)
        
        

        UIFont.familyNames.forEach({
            name in
            for font_name in UIFont.fontNames(forFamilyName: name){
                 print("\n\(font_name)")
            }
        })
        
        
        
        MOLH.shared.activate(true)
        print("language is \(NSLocale.current.languageCode!)")
        reset()
         
        
        return true
    

 }
    
    
   
       
        func reset() {
            if let app = UIApplication.shared.delegate?.window{
                if let rootViewController: UIWindow = app {
                    
                    let story = UIStoryboard(name: "Main", bundle: nil)
                                       rootViewController.rootViewController = story.instantiateViewController(withIdentifier: "splashScreen")
                }
                
            }
            
//                        if let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)
//                        {
//                            let story = UIStoryboard(name: "Home", bundle: nil)
//                                               rootViewController.rootViewController = story.instantiateViewController(withIdentifier: "tabBarSvc")
//            }
//
         }
       
        
       
    
        
    
        //if let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!{
            
        
        
   
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    
    

}

extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       print("Unable to register for remote notifications: \(error.localizedDescription)")
     }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        print("hello")
    }
    
    
    
    
    
    
}
