//
//  TheMovieDBTests.swift
//  TheMovieDBTests
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class TheMovieDBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieWithVoidDictionary() {
        let movieDic = [String: Any]()
        let movie = Movie(movieDic: movieDic)
        
        XCTAssertEqual(movie.movieTitle, " ")
        XCTAssertEqual(movie.movieRating, 0.0)
        XCTAssertEqual(movie.movieId, 0)
        XCTAssertEqual(movie.movieImageUrl, " ")
        
    }
    
    func testSearchMovieResponseWithVoidDictionary() {
        let searchDic = [String: Any]()
        let searchResponse = SearchMovieResponse(searchDic: searchDic)
        
        XCTAssertEqual(searchResponse.resultsNumber, 0)
        XCTAssertEqual(searchResponse.resultsList.count, 0)
    }
    
}
