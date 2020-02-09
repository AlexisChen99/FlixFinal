//
//  MovieDetailViewController.swift
//  
//
//  Created by Alexis Chen on 2/4/20.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var realseDateLabel: UILabel!
    
    var movies : [String:Any]! //array of dictionary
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //assign the title
        titleLabel.text = movies["title"] as? String
        titleLabel.sizeToFit()
        
        //assign synopsis
        synopsisLabel.text = movies["overview"] as? String
        synopsisLabel.sizeToFit()
        
        //assign realseDateLabel
        realseDateLabel.text  = movies["release_date"] as? String
        realseDateLabel.sizeToFit()
        
        //assign the poster
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movies["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        posterView.af_setImage(withURL: posterURL!) //reason why we don't have cell in the front is because posterView is already in this class
        
        //assign the backdrop
        let backdropPath = movies["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af_setImage(withURL: backdropURL!)
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
