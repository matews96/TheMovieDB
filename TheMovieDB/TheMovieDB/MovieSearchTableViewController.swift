//
//  MovieSearchTableViewController.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/29/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movies: [Movie]?
    var base_url: String?

    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        
        movieSearchBar.delegate = self
        
        
        //        SearchMovieRequest.configuration(){ response in
        //            guard let base_url = response?.baseUrl else {
        //                print("Problems with conf")
        //                return
        //            }
        //
        //
        //
        //        }
        
        
        
    }
    
    //SearchMovieRequest.configuration(){ response in
    
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    
    
    func search(_ searchQuery: String){
        
        MoviesApiFacade.makeRequest(query: searchQuery) { response in
            guard let movies = response?.resultsList else {
                return
            }
            print(movies)
            
            self.movies = movies
            
            for movie in self.movies!{
                
                MoviesApiFacade.getImage(queryUrl: "https://image.tmdb.org/t/p/w92"+movie.movieImageUrl){ response in
                    
                    movie.movieImage = response
                    self.tableView.reloadData()
                    
                }
                
                
            }
            
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("hola")
        movieSearchBar.resignFirstResponder()
        search(movieSearchBar?.text ?? "")
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieSearchBar.resignFirstResponder()
        performSegue(withIdentifier: "fromMovieSearchToDetail", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let movie = movies![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        
        cell.movieTitleLabel.text = movie.movieTitle
        cell.movieRatingLabel.text = "Rating: "+String(movie.movieRating )
        cell.movieImage.image = movies?[indexPath.row].movieImage
        
        //cell.textLabel?.text = movies?[indexPath.row].movieTitle ?? ""
        //cell.detailTextLabel?.text = String(movies?[indexPath.row].movieRating ?? 0)
        // cell.movieImage.af_setImage(withURL: URL(string: "https://image.tmdb.org/t/p/w92" + movie.movieImageUrl)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(self.movies?[indexPath.row].movieDescription ?? "Fuck")
        performSegue(withIdentifier: "fromMovieSearchToDetail", sender: movies?[indexPath.row])
 
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
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation


    
}
