//
//  MovieSearchTableViewController.swift
//  TheMovieDB
//
//  Created by Mateo Echeverri Yepes on 8/29/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movies: [Movie]?
    var base_url: String?
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.rowHeight = 180
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
        
        SearchMovieRequest.makeRequest(query: searchQuery) { response in
            guard let movies = response?.resultsList else {
                return
            }
            print(movies)
            
            self.movies = movies
            
            for movie in self.movies!{
                
                SearchMovieRequest.getImage(queryUrl: "https://image.tmdb.org/t/p/w92/"+movie.movieImageUrl){ response in
                    
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        
        cell.movieTitleLabel.text = movies?[indexPath.row].movieTitle ?? ""
        cell.movieRatingLabel.text = "Rating: "+String(movies?[indexPath.row].movieRating ?? 0)
        cell.movieImage.image = movies?[indexPath.row].movieImage
        
        //cell.textLabel?.text = movies?[indexPath.row].movieTitle ?? ""
        //cell.detailTextLabel?.text = String(movies?[indexPath.row].movieRating ?? 0)
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
