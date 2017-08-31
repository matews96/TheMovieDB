//
//  Modelo.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/31/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

class Configuration {
    
    var baseUrl: String
    
    init(configDic: [String:Any]){
        
        guard let image = (configDic["images"] as? [String: Any]) else {
            self.baseUrl = ""
            return
        }
        
        self.baseUrl = image["base_url"] as? String ?? ""
    }
    
    
    
}

class SearchMovieResponse {
    
    var resultsNumber: Int
    var resultsList: [Movie] = []
    
    init(searchDic: [String:Any]) {
        self.resultsNumber = (searchDic["total_results"] as? Int) ?? 0
        for movie in (searchDic["results"] as? [[String:Any]]) ?? [] {
            
            self.resultsList.append(Movie(movieDic: movie))
            
        }
    }
    //print((resultsList.first?.movieTitle)!)
}

class Movie {
    
    var movieTitle: String
    var movieRating: Float
    var movieId: Int
    var movieImage: UIImage?
    var movieImageUrl: String
    
    init(movieDic: [String:Any]) {
        
        self.movieTitle = (movieDic["original_title"] as? String) ?? " "
        self.movieRating = (movieDic["vote_average"] as? Float) ?? 0.0
        self.movieId = (movieDic["id"] as? Int) ?? 0
        self.movieImageUrl = (movieDic["poster_path"] as? String) ?? " "
        
        
        
    }
    
}
