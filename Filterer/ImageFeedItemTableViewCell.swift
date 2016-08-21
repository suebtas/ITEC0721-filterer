//
//  ImageFeedItemTableViewCell.swift
//  Filterer
//
//  Created by Suebtas on 8/20/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

class ImageFeedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    weak var dataTask: NSURLSessionDataTask?
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
