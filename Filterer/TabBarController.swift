//
//  TabBarController.swift
//  Filterer
//
//  Created by Suebtas on 8/21/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier! == "imageFeed" {
            if let destination = segue.destinationViewController as? UINavigationController {
                _ = destination.topViewController as! ImageFeedTableViewController
                // set whatever variables on destVC
                print("ok")
            }
       // }
        
    }
}
