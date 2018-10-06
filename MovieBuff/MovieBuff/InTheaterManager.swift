//
//  InTheaterManager.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/10/6.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation
import Alamofire

protocol InTheaterManagerDelegate: class {
    
    func manager(_ manager: InTheaterManager, didGet products: OMDBData)
    
    func manager(_ manager: InTheaterManager, didFailWith error: Error)

}

struct InTheaterManager {
    
    weak var delegate: InTheaterManagerDelegate?
    
    func requestOMDBData() {
        
        let decoder = JSONDecoder()
        
        guard let url = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=47832d63") else {
            
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

protocol InTheaterTrailerManagerDelegate: class {
    
    func manager(_ manager: InTheaterTrailerManager, didGet products: TrailerData)
    
    func manager(_ manager: InTheaterTrailerManager, didFailWith error: Error)
    
}

struct InTheaterTrailerManager {
    
    weak var delegate: InTheaterTrailerManagerDelegate?
    
    func requestTrailerData() {
        
        let decoder = JSONDecoder()
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/tt2582802/videos?api_key=05dd8085592c47e1b919c06e49e61126&language=en-US") else {
            
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

