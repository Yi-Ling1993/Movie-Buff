//
//  FirebaseData.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/5.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation

struct FirebaseData: Codable {
    
    let inTheater: [MovieInfo]
    let thisWeek: [MovieInfo]
    let soon: [MovieInfo]
    let theater: [CinemaInfo]
}

struct  MovieInfo: Codable {
    
    let title: String
    let id: String
    let releaseDate: String
    let rated: String
    let theater: [MovieTheaterInfo]?
}

struct MovieTheaterInfo: Codable {
    
    let theaterName: String?
    let region: String?
    let language: String?
    let present: String?
    let showtime: [ShowtimeInfo]?
}

struct ShowtimeInfo: Codable {
    
    let date: String?
    let time: [String]?
}

struct CinemaInfo: Codable {
    
    let name: String
    let movie: String?
    let region: String
}
