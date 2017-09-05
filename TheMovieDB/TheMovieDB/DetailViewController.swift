//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    var movie: Movie?
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        movieImage.image = movie!.movieImageBig
        overviewLabel.text = movie?.movieDescription ?? ""
        ratingLabel.text = String(movie!.movieRating)
        
        

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }    
}

