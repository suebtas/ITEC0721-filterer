//
//  SettingViewController.swift
//  Filterer
//
//  Created by Suebtas on 8/20/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var dateLabel: UILabel!
    @IBAction func updateButtonAction(sender: AnyObject) {
        let now = NSDate()
        NSUserDefaults.standardUserDefaults().setObject(now, forKey:"buttonTapped")
        self.updateLabel()
    }
    func updateLabel() -> Void{
        
        let lastUpdate = NSUserDefaults.standardUserDefaults().objectForKey("buttonTapped")as? NSDate
        if let hasLastUpdate = lastUpdate{
            self.dateLabel.text = hasLastUpdate.description
        } else {
            self.dateLabel.text = "No date saved."
        }
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
