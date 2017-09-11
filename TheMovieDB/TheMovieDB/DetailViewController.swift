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
    @IBOutlet weak var movieTitle: UINavigationItem!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var movie: Movie?
 
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatDataLabels()


    }
    
    private func formatDataLabels(){
        
        let boldFormat = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        let normalFormat = [NSFontAttributeName : UIFont.systemFont(ofSize: 18)]
        
        let movieDescription = movie?.movieDescription ?? ""
        let tagLine = " " + (movie?.tagLine ?? "")
        
        let overview = NSMutableAttributedString(string: movieDescription, attributes: normalFormat)
        let date = NSMutableAttributedString(string:("Release: "), attributes: boldFormat)
        let rating = NSMutableAttributedString(string:("Rating: "), attributes: boldFormat)
        let duration = NSMutableAttributedString(string:("Duration: "), attributes: boldFormat)
        let numberOfVotes = NSMutableAttributedString(string:("Vote Count: "), attributes: boldFormat)
        
        date.append(NSMutableAttributedString(string: (movie?.releaseDate ?? ""), attributes: normalFormat))
        rating.append(NSMutableAttributedString(string: String(movie?.movieRating ?? 0), attributes: normalFormat))
        duration.append(NSMutableAttributedString(string: (movie?.duration ?? ""), attributes: normalFormat))
        numberOfVotes.append(NSMutableAttributedString(string: (movie?.voteCount ?? ""), attributes: normalFormat))
        overview.append(NSMutableAttributedString(string:tagLine, attributes:boldFormat))
        
        
        movieImage.image = movie!.movieImageBig
        movieTitle.title = movie!.movieTitle
        overviewText.attributedText = overview
        ratingLabel.attributedText = rating
        voteCountLabel.attributedText = numberOfVotes
        releaseDateLabel.attributedText = date
        durationLabel.attributedText = duration
        
    }
    
}

