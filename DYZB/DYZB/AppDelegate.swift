//
//  AppDelegate.swift
//  DYZB
//
//  Created by Raymond on 2016/12/23.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        UITabBar.appearance().tintColor = UIColor.orange
        // 设置导航栏的背景颜色
        let bar = UINavigationBar.appearance()
        bar.barTintColor = UIColor.orange
        return true
    }
}

