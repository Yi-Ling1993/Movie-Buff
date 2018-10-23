//
//  OMDBData.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/6.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation

struct OMDBData: Codable {
    
    //swiftlint:disable identifier_name
    
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let imdbRating: String
    let imdbID: String
    let Response: String
}
