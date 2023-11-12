//
//  AppDelegate.swift
//  OffWhite-SmartHack
//
//  Created by Aldea Alexia on 11.11.2023.
//

import Foundation
import UIKit
import netfox
//import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
        NFX.sharedInstance().start()
        
        // speed up improvment
        let _ = BusinessSectorService.shared.getAllBusniessSectors()
//        let _ = CompaniesAPI.shared.getAllCompanies(activityDomain: ["Artificial Intelligence", "E-Commerce","Green Energy","Manufacturing","Telecommunications"], location: "China")
//        let _ = CompaniesAPI.shared.getCompanyDetails(companyName: "Apple", address: "USA")
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
