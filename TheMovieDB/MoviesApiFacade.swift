//
//  SearchMovieRequest.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/23/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class MoviesApiFacade {
    
    static func makeFeaturedRequest(handler: @escaping (SearchMovieResponse?) -> Void) {
        
        
        
        let queryString = "https://api.themoviedb.org/3/discover/movie?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        let queryUrl = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = queryUrl else{print("The url could not be parsed correctly"); return}
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                handler(nil)
                print("the JSON object could not be casted [String:Any]")
                return
            }
            
            
            
            let response = SearchMovieResponse(searchDic: json)
            print(response.resultsNumber)
            handler(response)
            
            
        }
    }
    
    

    
    
    static func configuration(handler:  @escaping (Configuration?) -> Void){
        
        
        let queryString = "https://api.themoviedb.org/3/configuration?api_key=1f4d7de5836b788bdfd897c3e0d0a24b"
        let queryUrl = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = queryUrl else{print("The url could not be parsed correctly"); return}
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                handler(nil)
                print("the JSON object could not be casted [String:Any]")
                return
            }
        
            let response = Configuration(configDic: json)
            
            handler(response)
        
    }
    }
    
    static func makeRequest(query: String, handler: @escaping (SearchMovieResponse?) -> Void) {
        

        
        let queryString = "https://api.themoviedb.org/3/search/movie?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US&query=\(query)&page=1&include_adult=false"
        let queryUrl = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = queryUrl else{print("The url could not be parsed correctly"); return}
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                handler(nil)
                print("the JSON object could not be casted [String:Any]")
                return
            }
            
            
            
            let response = SearchMovieResponse(searchDic: json)
            print(response.resultsNumber)
            handler(response)
            

        }
    }
    
    static func makeDetailRequest(query: String, handler: @escaping (String?) -> Void) {
        
        
        
        let queryString = "https://api.themoviedb.org/3/movie/\(query)?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US"
        let queryUrl = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = queryUrl else{print("The url could not be parsed correctly"); return}
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {
                handler(nil)
                print("the JSON object could not be casted [String:Any]")
                return
            }
            
            
            
            let response = json["overview"] as? String ?? "fil"
           // print(response)
            handler(response)
            
            
        }
    }
    
    static func getImage(queryUrl: String, handler: @escaping (UIImage?) -> Void){
        var movieImage: UIImage?
        
        Alamofire.request(queryUrl).responseData { response in

            if let image = response.result.value  {
                movieImage = UIImage(data: image)
                
            }else{
                print("error")
                print(queryUrl)
            }
            
            
            handler(movieImage)
        }
        
        
    }
}

// Cosas del modelo


