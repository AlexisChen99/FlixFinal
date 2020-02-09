//
//  Movie MovieViewController.swift
//  Flixy
//
//  Created by Alexis Chen on 1/29/20.
//  Copyright © 2020 Alexis Chen. All rights reserved.
//

import UIKit
import AlamofireImage

//step one, addutitableviewdatasource and delegate
class Movie_MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //step one
    @IBOutlet weak var tableV: UITableView! //stand for table view
    
    var movies = [[String:Any]]() //array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()//run the first time the screen comes out

        //step three
        tableV.dataSource = self
        tableV.delegate = self
        
        
        //fetch data
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movies = dataDictionary["results"] as! [[String:Any]] //cast as array dictionary
            //step 4, need to update and reload the data by calling the functions again
            self.tableV.reloadData()
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    //step two add two functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //asking the number of movie
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //give me the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //assign movie
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        //what the cell would say
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185" //the url
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)   //combine the two
        
        cell.poster.af_setImage(withURL: posterUrl!) //deal with the url
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //do things in between switching screens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find the selected movie, sender is the cell that was tapped on
        let cell = sender as! UITableViewCell   //store the one tapped into cell
        let indexPath = tableV.indexPath(for: cell)!    //find the index path of that cell
        let movie = movies[indexPath.row]
        
        //pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailViewController
        detailsViewController.movies = movie
        
        //deselect
        tableV.deselectRow(at: indexPath, animated: true)
        
        //then we would leave the rest of doing things to moivedetailviewcontroller
        
    }
    

}
