//
//  SearchMovieRequest.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/23/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import Alamofire


class SearchMovieRequest {
    
    static func makeRequest(query: String) {
        
        let queryString = "https://api.themoviedb.org/3/search/movie?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US&query=\(query)&page=1&include_adult=false"
        let queryUrl = queryString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = queryUrl else{print("The url could not be parsed correctly"); return}
        
        Alamofire.request(url).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else {print("the JSON object could not be casted [String:Any]"); return}
            let response = SearchMovieResponse(json: json)
            print(response.resultsNumber)
            
        }
    }
}

class SearchMovieResponse {
    
    var resultsNumber: Int
    var resultsList: [Movie] = []
    
    init(json: [String:Any]) {
        self.resultsNumber = (json["total_results"] as? Int) ?? 0
        for movie in (json["results"] as? [[String:AnyObject]]) ?? [] {
            self.resultsList.append(Movie(json: movie))
        }
        print((resultsList.first?.movieTitle)!)
    }
}

class Movie {
    
    var movieTitle: String
    var movieRating: Float
    var movieId: Int
    
    init(json: [String:Any]) {
        self.movieTitle = (json["original_title"] as? String) ?? " "
        self.movieRating = (json["vote_average"] as? Float) ?? 0.0
        self.movieId = (json["id"] as? Int) ?? 0
    }
    
}
