//
//  ThisWeekManager.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/14.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation
import Alamofire

protocol ThisWeekManagerDelegate: class {
    
    func manager(_ manager: ThisWeekManager, didGet products: OMDBData)
    
    func manager(_ manager: ThisWeekManager, didFailWith error: Error)
    
}

struct ThisWeekManager {
    
    weak var delegate: ThisWeekManagerDelegate?
    
    func requestOMDBData(imdbId: String) {
        
        let decoder = JSONDecoder()
        
        guard let url = URL(string: "http://www.omdbapi.com/?i=\(imdbId)&apikey=47832d63") else {
            
            return
        }
        
        Alamofire.request(url)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success:
                    if let data = response.data {
                        do {
                            let omdbData = try decoder.decode(OMDBData.self, from: data)
                            self.delegate?.manager(self, didGet: omdbData)
                        } catch let error {
                            self.delegate?.manager(self, didFailWith: error)
                        }
                    }
                    
                case .failure:
                    
                    print("fail")
                }
        }
    }
}

protocol ThisWeekTrailerManagerDelegate: class {
    
    func manager(_ manager: ThisWeekTrailerManager, didGet products: TrailerData)
    
    func manager(_ manager: ThisWeekTrailerManager, didFailWith error: Error)
    
}

struct ThisWeekTrailerManager {
    
    weak var delegate: ThisWeekTrailerManagerDelegate?
    
    func requestTrailerData(imdbId: String) {
        
        let decoder = JSONDecoder()
        
        //swiftlint:disable line_length
        
        guard let url = URL(string:
            "https://api.themoviedb.org/3/movie/\(imdbId)/videos?api_key=05dd8085592c47e1b919c06e49e61126&language=en-US") else {
            
            return
        }
        
        Alamofire.request(url)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success:
                    if let data = response.data {
                        do {
                            let trailerData = try decoder.decode(TrailerData.self, from: data)
                            self.delegate?.manager(self, didGet: trailerData)
                        } catch let error {
                            self.delegate?.manager(self, didFailWith: error)
                        }
                    }
                    
                case .failure:
                    
                    print("fail")
                }
        }
    }
}
