//
//  CollectionViewCell.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/31/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
