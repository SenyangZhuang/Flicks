//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by Senyang Zhuang on 1/30/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: infoView.frame.origin.y + infoView.frame.height)
       
        titleLabel.text = movie["title"] as! String

        overviewLabel.text = movie["overview"] as! String
                 overviewLabel.sizeToFit()
        if let posterPath = movie["poster_path"] as? String {
            
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            //            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            let imageUrl = NSURL(string: posterBaseUrl + posterPath)!
            //            cell.posterView.setImageWithURL(posterUrl!)
            posterView.setImageWithURL(imageUrl)
        }
   

        print(movie)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
