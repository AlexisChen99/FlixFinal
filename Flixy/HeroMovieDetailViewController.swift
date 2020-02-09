//
//  HeroMovieDetailViewController.swift
//  Flixy
//
//  Created by Alexis Chen on 2/9/20.
//  Copyright © 2020 Alexis Chen. All rights reserved.
//

import UIKit
import AlamofireImage

class HeroMovieDetailViewController: UIViewController {
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    //the movie it is currently in now
    var movie : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //assign title
        movieTitleLabel.text = movie["title"] as? String
        movieTitleLabel.sizeToFit()
        
        //assign release time
        timeLabel.text = movie["release_date"] as? String
        timeLabel.sizeToFit()
        
        //assign synopsis
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        //poster view
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        posterView.af_setImage(withURL: posterURL!) //reason why we don't have cell in the front is because posterView is already in this class
        
        //assign the backdrop
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backDropView.af_setImage(withURL: backdropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
