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
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1.0)

        Fabric.with([Crashlytics.self])
        
        GMSServices.provideAPIKey("AIzaSyD813UwWssk66FntLWLhWotasHUAl99080")
        
        FirebaseApp.configure()
        
        // 有 storyboard 就要用 storyboard 的初始化方法
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: "Landing")
        
//        let rootVC = storyboard.instantiateViewController(withIdentifier: "InTheater")
        
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.shadowColor = UIColor.gray.withAlphaComponent(0.5)

        options.backgroundImage = UIImage(named: "blur1-576x1024")
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

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
