//
//  FilterGrayscale.swift
//  Filterer
//
//  Created by Suebtas on 8/13/2559 BE.
//  Copyright © 2559 UofT. All rights reserved.
//

import UIKit
public class FilterGrayscale {
    var intensity: Double = 0.0
    
    // Make the image grayscale
    public var filtername: String {
        return "Grayscale Filter"
    }
    
    public init (intensity: Double = 10.0) {
        self.intensity = intensity
    }
    public func run(rgbaImage: RGBAImage) -> RGBAImage {
        // apply a filter to each pixel of the image
        let intensity = self.intensity / 5
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                // coefficients obtained from:
                // http://stackoverflow.com/questions/687261/converting-rgb-to-grayscale-intensity
                let red = 0.2126 * intensity * Double(pixel.red)
                let green = 0.5870 * intensity * Double(pixel.green)
                let blue = 0.1140 * intensity * Double(pixel.blue)
                let l = red + green + blue
                
                pixel.red = UInt8(min(l, 255))
                pixel.green = UInt8(min(l, 255))
                pixel.blue = UInt8(min(l, 255))
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage
    }
}
