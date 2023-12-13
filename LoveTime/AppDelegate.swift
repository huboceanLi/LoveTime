//
//  AppDelegate.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/10/16.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LTDataBaseTool.default.initDB(userID: "3498trgfhadskf")
        IQKeyboardManager.shared.enableAutoToolbar = true

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        let vc = BaseTabBarController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

