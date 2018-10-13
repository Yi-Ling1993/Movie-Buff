//
//  MenuItem.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/27.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

struct MenuItems {
    
    fileprivate let titles = ["上映中", "本週上映", "即將上映", "電影院"]
    fileprivate let icons  = [Image.inTheaterImage, Image.thisWeekImage, Image.soonImage, Image.cinemaImage]
    
    var count: Int {
        return self.titles.count
    }
    
    func getTitle(_ index: Int) -> String {
        return self.titles[index]
    }
    
    func getIcon(_ index: Int) -> UIImage {
        return self.icons[index]
    }
    
}
