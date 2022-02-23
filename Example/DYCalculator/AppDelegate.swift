//
//  AppDelegate.swift
//  DYCalculator
//
//  Created by BigBroDongYang on 02/23/2022.
//  Copyright (c) 2022 BigBroDongYang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window_config()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func window_config(){
        window = UIWindow.init(frame: UIScreen.main.bounds)
        if #available(iOS 13, *) {
            window?.backgroundColor = .systemBackground
        }else {
            window?.backgroundColor = .white
        }
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
    
    
}

