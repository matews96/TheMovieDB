//
//  FeaturedMoviesCollectionViewController.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/31/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

private let reuseIdentifier = "Cell"

class FeaturedMoviesCollectionViewController: UICollectionViewController{

    
    var movies: [Movie]?
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!

    let size = CGSize(width: 175 , height: 285)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featured()
        print("he cargado")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        
        self.layout.itemSize = size
        
        self.layout.minimumInteritemSpacing = CGFloat(10)
        
        self.layout.minimumLineSpacing = CGFloat(10)
        
        self.layout.sectionInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func featured(){
        
        MoviesApiFacade.makeFeaturedRequest() { response in
            guard let movies = response?.resultsList else {
                return
            }
            print(movies)
            
            self.movies = movies
            
            for movie in self.movies!{
                
                MoviesApiFacade.getImage(queryUrl: "https://image.tmdb.org/t/p/w185"+movie.movieImageUrl){ response in
                    
                    movie.movieImage = response
                    self.collectionView!.reloadData()
                }
                
                
            }
            
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = movies![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
    
        // Configure the cell
        
        cell.movieImage.image = movie.movieImage
        cell.movieLabel.text = movie.movieTitle
    
        return cell
    }
    

    


    // MARK: UICollectionViewDelegate

   
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
  
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        performSegue(withIdentifier: "fromFeaturedToDetail", sender: movies?[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! DetailViewController
        
        guest.movie = sender as! Movie?
        let id = String(guest.movie?.movieId ?? 0)
        print(id)
        
        MoviesApiFacade.getImage(queryUrl: "https://image.tmdb.org/t/p/w500"+guest.movie!.movieImageUrl){ response in
            
            guest.movie?.movieImageBig = response
            guest.viewDidLoad()
            
        }
        MoviesApiFacade.makeDetailRequest(query: id) { response in
            guard let overview = response else {
                return
            }
            guest.movie?.movieDescription = overview
            guest.viewDidLoad()
            
            
        }
        
        
    }
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
