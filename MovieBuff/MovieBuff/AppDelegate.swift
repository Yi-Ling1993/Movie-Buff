//
//  AppDelegate.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/19.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import GoogleMaps
import WKAwesomeMenu
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyD813UwWssk66FntLWLhWotasHUAl99080")
        
        FirebaseApp.configure()
        
        // 有 storyboard 就要用 storyboard 的初始化方法
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: "InTheater")
        
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.backgroundImage = UIImage(named: "bg")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = awesomeMenu
        self.window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
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

}
