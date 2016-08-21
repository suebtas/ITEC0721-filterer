import Foundation

struct FeedItem {
    let title: String
    let imageURL: NSURL
}


func fixJsonData (data: NSData) -> NSData {
    var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
    dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    return dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    
}


public class Feed {
    
    let items: [FeedItem]
    let sourceURL: NSURL
    
    init (items newItems: [FeedItem], sourceURL newURL: NSURL) {
        self.items = newItems
        self.sourceURL = newURL
    }
    
    convenience init? (data: NSData, sourceURL url: NSURL) {
        
        var newItems = [FeedItem]()
        
        let fixedData = fixJsonData(data)
        
        var jsonObject: Dictionary<String, AnyObject>?
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(fixedData, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String,AnyObject>
        } catch {
            
        }
        
        guard let feedRoot = jsonObject else {
            return nil
        }
        
        guard let items = feedRoot["items"] as? Array<AnyObject>  else {
            return nil
        }
        
        
        for item in items {
            
            guard let itemDict = item as? Dictionary<String,AnyObject> else {
                continue
            }
            guard let media = itemDict["media"] as? Dictionary<String, AnyObject> else {
                continue
            }
            
            guard let urlString = media["m"] as? String else {
                continue
            }
            
            guard let url = NSURL(string: urlString) else {
                continue
            }
            
            let title = itemDict["title"] as? String
            
            newItems.append(FeedItem(title: title ?? "(no title)", imageURL: url))
            
        }
        
        self.init(items: newItems, sourceURL: url)
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
    
    
    let dataFile = NSBundle.mainBundle().URLForResource("photos_public.gne", withExtension: ".js")!
    let data = NSData(contentsOfURL: dataFile)!
    let feed = Feed(data: data, sourceURL: url)
    completion(feed: feed)
    
}

if let url = NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?tags=Kitten&format=json&nojsoncallback=1" ) {
    
    updateFeed(url, completion: { (feed) -> Void in
        var sss:Feed  = feed!
        print(sss)
        
    })
}

