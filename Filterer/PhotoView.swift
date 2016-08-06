//
//  PhotoView.swift
//  Filterer
//
//  Created by Suebtas on 8/7/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {
    var lastTouchTime: NSDate? = nil
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        if let touch = touches.first{
            let location = touch.locationInView(self)
            print("x:\(location.x) y:\(location.y)")
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let currentTime = NSDate()
        if let previousTime = lastTouchTime {
            if currentTime.timeIntervalSinceDate(previousTime) < 0.5
            {
                print("Double Tap")
                lastTouchTime = nil
            }else{
                lastTouchTime = currentTime
            }
        }else{
            lastTouchTime = currentTime
        }
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
    
    }

}
