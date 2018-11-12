//
//  LandingPageViewController.swift
//  Taipei Movies
//
//  Created by 劉奕伶 on 2018/10/18.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import WKAwesomeMenu
import Lottie

class LandingPageViewController: UIViewController {
    
    //swiftlint:disable force_cast
    
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
        
        let animationView = LOTAnimationView(name: "empty_box")

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        animationView.frame = CGRect(x: 0, y: 0, width: 170, height: 170)
        animationView.center = CGPoint(x: screenWidth / 2, y: screenHeight * 0.83)
        animationView.contentMode = .scaleAspectFill
        
        animationView.loopAnimation = true
        animationView.animationSpeed = 0.5
        
        view.addSubview(animationView)
        
        animationView.play()
    }
}
