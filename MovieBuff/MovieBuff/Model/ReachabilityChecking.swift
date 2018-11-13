//
//  ReachabilityChecking.swift
//  Taipei Movies
//
//  Created by 劉奕伶 on 2018/11/13.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation
import UIKit

class ReachabilityChecking {
    
    static func checkInternetFunction() -> Bool {
        
        let reachability = Reachability(hostName: "www.apple.com")
        
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            print("no internet connected.")
            return false
        } else {
            print("internet connected successfully.")
            return true
        }
    }
    
    static func showLabelOrNot(label: UILabel) {
        
        label.isHidden = checkInternetFunction()
        
    }
}
