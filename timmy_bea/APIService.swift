//
//  APIService.swift
//  timmy_bea
//
//  Created by Tim Beals on 2018-09-19.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation

struct APIService {
    
    static fileprivate let baseURL: String = "https://timmybea.github.io/timmybeaAPI/"
    
    enum APIURL {
        case json
        case image(endPoint: String)
        
        var path: String {
            switch self {
            case .json: return APIService.baseURL + "dataObjects.json"
            case .image(let endPoint): return APIService.baseURL + "personImage/" + endPoint
            }
        }
        
        var url: URL {
            switch self {
            case .json: return URL(string: self.path)!
            case .image(_): return URL(string: self.path)!
            }
        }
    }
    
    enum APIServiceError: Error {
        case noData
    }
    
    static func fetchData(with apiURL: APIURL, completion: @escaping (Data?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: apiURL.url ) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let unwrapData = data else {
                completion(nil, APIServiceError.noData)
                return
            }
            
            completion(unwrapData, nil)
            
            }.resume()
        
    }
}
