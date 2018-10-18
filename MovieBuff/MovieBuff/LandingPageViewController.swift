//
//  LandingPageViewController.swift
//  Taipei Movies
//
//  Created by 劉奕伶 on 2018/10/18.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import WKAwesomeMenu

class LandingPageViewController: UIViewController {
    
    @IBAction func toInTheater(_ sender: UIButton) {
        self.performSegue(withIdentifier: "first", sender: self)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "InTheater")
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.shadowColor = UIColor.gray.withAlphaComponent(0.5)
        
        options.backgroundImage = UIImage(named: "blur1-576x1024")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)

        appDelegate.window?.rootViewController = awesomeMenu
        appDelegate.window?.makeKeyAndVisible()

    }
    
    @IBAction func toThisWeek(_ sender: UIButton) {
        self.performSegue(withIdentifier: "second", sender: self)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ThisWeek")
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.shadowColor = UIColor.gray.withAlphaComponent(0.5)
        
        options.backgroundImage = UIImage(named: "blur1-576x1024")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)
        
        appDelegate.window?.rootViewController = awesomeMenu
        appDelegate.window?.makeKeyAndVisible()

    }
    
    @IBAction func toSoon(_ sender: UIButton) {
        self.performSegue(withIdentifier: "third", sender: self)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "Soon")
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.shadowColor = UIColor.gray.withAlphaComponent(0.5)
        
        options.backgroundImage = UIImage(named: "blur1-576x1024")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)
        
        appDelegate.window?.rootViewController = awesomeMenu
        appDelegate.window?.makeKeyAndVisible()

    }
    
    @IBAction func toTheater(_ sender: UIButton) {
        self.performSegue(withIdentifier: "fourth", sender: self)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "TheaterList")
        let menuVC = MenuTableViewController()
        
        var options = WKAwesomeMenuOptions.defaultOptions()
        options.shadowColor = UIColor.gray.withAlphaComponent(0.5)
        
        options.backgroundImage = UIImage(named: "blur1-576x1024")
        let awesomeMenu = WKAwesomeMenu(rootViewController: rootVC, menuViewController: menuVC, options: options)
        
        appDelegate.window?.rootViewController = awesomeMenu
        appDelegate.window?.makeKeyAndVisible()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
