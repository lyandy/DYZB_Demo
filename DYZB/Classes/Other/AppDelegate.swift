//
//  AppDelegate.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/16.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.backgroundColor = UIColor.white
        
        UITabBar.appearance().tintColor = UIColor.orange;
        
        return true
    }
}

