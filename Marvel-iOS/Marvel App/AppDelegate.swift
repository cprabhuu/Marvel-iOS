//
//  AppDelegate.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 15/03/16.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //__ Set custom navigation appearace
        customNavigation()
        //__ Set custom table view's appearace
        customTableView()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    func customNavigation() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.whiteColor()
        navigationBarAppearace.barTintColor = UIColor.nagitationBarColor()
        //__ Change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent        
    }
    
    func customTableView() {
        let tableViewAppearace = UITableView.appearance()
        tableViewAppearace.sectionIndexBackgroundColor = UIColor.clearColor()
        tableViewAppearace.backgroundColor = UIColor.clearColor()
    }
}

