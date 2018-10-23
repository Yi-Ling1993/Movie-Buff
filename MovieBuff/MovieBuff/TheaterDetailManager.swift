//
//  TheaterDetailManager.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/14.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation
import Alamofire

protocol TheaterDetailManagerDelegate: class {
    
    func manager(_ manager: TheaterDetailManager, didGet products: OMDBData)
    
    func manager(_ manager: TheaterDetailManager, didFailWith error: Error)
    
}

struct TheaterDetailManager {
    
    weak var delegate: TheaterDetailManagerDelegate?
    
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

protocol TheaterDetailTrailerManagerDelegate: class {
    
    func manager(_ manager: TheaterDetailTrailerManager, didGet products: TrailerData)
    
    func manager(_ manager: TheaterDetailTrailerManager, didFailWith error: Error)
    
}

struct TheaterDetailTrailerManager {
    
    weak var delegate: TheaterDetailTrailerManagerDelegate?
    
    func requestTrailerData(imdbId: String) {
        
        let decoder = JSONDecoder()
        
        //swiftlint:disable line_length

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(imdbId)/videos?api_key=05dd8085592c47e1b919c06e49e61126&language=en-US") else {
            
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
