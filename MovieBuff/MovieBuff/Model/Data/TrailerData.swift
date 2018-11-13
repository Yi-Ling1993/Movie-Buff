//
//  TrailerData.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/6.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation

struct TrailerData: Codable {
    
    let id: Int
    let results: [TrailerInfo]
}

struct TrailerInfo: Codable {
    
    //swiftlint:disable identifier_name
    
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}
