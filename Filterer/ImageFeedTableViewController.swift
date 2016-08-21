//
//  ImageFeedTableViewController.swift
//  Filterer
//
//  Created by Suebtas on 8/20/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

class ImageFeedTableViewController: UITableViewController {
    var feed: Feed? {
        didSet {
            self.tableView.reloadData()
        }
    }
    func updateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        
        let request = NSURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let feed = Feed(data: data!, sourceURL: url)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(feed: feed)
                })
            }
            
        }
        
        task.resume()
        
        /*
         let dataFile = NSBundle.mainBundle().URLForResource("photos_public.gne", withExtension: ".js")!
         let data = NSData(contentsOfURL: dataFile)!
         let feed = Feed(data: data, sourceURL: url)
         completion(feed: feed)
         */
    }
    override func viewDidLoad() {
        let urlString = NSUserDefaults.standardUserDefaults().objectForKey("PhotoFeedURLString")
        print(urlString)
        guard let foundURLString = urlString else {
            return
        }
        
        if let url = NSURL(string: foundURLString as! String) {
            self.updateFeed(url, completion: { (feed) -> Void in
                self.feed = feed
            })
        }
    }
    var urlSession: NSURLSession!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed?.items.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageFeedItemTableViewCell", forIndexPath: indexPath) as! ImageFeedItemTableViewCell
        
        let item = self.feed!.items[indexPath.row]
        cell.itemTitle.text = item.title
        
        
        
        let request = NSURLRequest(URL: item.imageURL)
        
        cell.dataTask = self.urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if error == nil && data != nil {
                    let image = UIImage(data: data!)
                    cell.itemImageView.image = image
                }
            })
            
        }
        
        
        
        cell.dataTask?.resume()
        
        return cell
    }
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ImageFeedItemTableViewCell {
            cell.dataTask?.cancel()
        }
    }
}
