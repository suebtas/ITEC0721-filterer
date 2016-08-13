//
//  FilterRed.swift
//  Filterer
//
//  Created by Suebtas on 8/13/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit

public class FilterRed {
    var intensity: Double = 0.0
    
    
    // Image filter base class
    public var filtername: String {
        return "Filter"
    }
    
    public func calculate_averages(rgbaImage: RGBAImage) -> (avgRed: Int, avgGreen: Int, avgBlue: Int) {
        // Each pixel is made up of a red, green, and blue value.
        // Return the average red value across all pixels, the average green, and average blue.
        // The average red value is the sum of all red values, divided by the total number of pixels.  And so on for the other colors.
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = totalRed / pixelCount
        let avgGreen = totalGreen / pixelCount
        let avgBlue = totalBlue / pixelCount
        
        return (avgRed, avgGreen, avgBlue) // TODO cache these values
    }
    
    public init (intensity: Double = 10.0) {
        self.intensity = intensity
    }
    
    
    public func run(rgbaImage: RGBAImage) -> RGBAImage {
        let averages = calculate_averages(rgbaImage)
        
        // apply a filter to each pixel of the image
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - averages.avgRed
                // increase the reds, don't modify blues and greens
                if (Int(pixel.red) > averages.avgRed) {
                    pixel.red = UInt8(max(min(255, (Double(averages.avgRed) + self.intensity * Double(redDelta))), 0))
                } else {
                    
                }
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage
    }
}

