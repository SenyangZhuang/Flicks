//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Senyang Zhuang on 1/24/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var movies: [NSDictionary]?
    var endpoint: String!
    @IBOutlet weak var tableView: UITableView!
//    var controller = UIRefreshControl()
    
//    @IBOutlet weak var myImageView: UIImageView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
//                            print("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                            
                    }
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
        })
        task.resume()
        self.tableView.addSubview(self.refreshControl)
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        //let newMovie = Movie(title: "Serenity", genre: "Sci-fi")
        //movies.append(newMovie)
        
       // movies.sort() { $0.title < $1.title }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{
            return movies.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if let posterPath = movie["poster_path"] as? String {
          
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
//            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            let imageRequest = NSURLRequest(URL: NSURL(string: posterBaseUrl + posterPath)!)
//            cell.posterView.setImageWithURL(posterUrl!)
            
            cell.posterView.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        cell.posterView.alpha = 0.0
                        cell.posterView.image = image
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            cell.posterView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        cell.posterView.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
                    
            })
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
//            print("QQQQQ")
            cell.posterView.image = nil
        }
        
        
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
//         MBProgressHUD.hideHUDForView(self.view, animated: true)
//        cell.posterView.setImageWithURL(imageUrl!)
        
        
//        print("row \(indexPath.row)")
        return cell
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
        
        
        
        

    }
    

}
