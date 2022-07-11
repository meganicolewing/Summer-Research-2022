//
//  analyzePixels.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/21/22.
//

import Foundation
import SwiftUI
import UIKit
//averages RGB values across image, returns a string containing the average RGB values
func analyzePixels(_ image: UIImage) -> String {
    //acesses image data to process
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    //used to hold the current value
    var currRed:Double = 0
    var currBlue:Double = 0
    var currGreen:Double = 0
    //used to count up the total values
    var avgRed:Double = 0
    var avgBlue:Double = 0
    var avgGreen:Double = 0
    var numPixels = 0
    //string to add the RGB values to once processing is complete
    var rgbValues = ""
    
    assert(cgImage.colorSpace?.model == .rgb)

    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent

    //goes through each pixel of the image and adds the RGB values to the appropriate variable
    for y in 0 ..< cgImage.height {
        for x in 0 ..< cgImage.width {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            //let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            currRed = (Double(bytes[offset]))
            currBlue = (Double(bytes[offset + 2]))
            currGreen = (Double(bytes[offset + 1]))
            if currRed > 75 || currBlue > 75 || currGreen > 75 {
                avgRed = (currRed + avgRed)
                avgGreen = (currGreen + avgGreen)
                avgBlue = (currBlue + avgBlue)
                numPixels += 1
            }
            //rgbValues = rgbValues + "[x:\(x), y:\(y)] \(components)\n"
        }
    }
    
    avgRed = avgRed / Double(numPixels)
    avgGreen = avgGreen / Double(numPixels)
    avgBlue = avgBlue / Double(numPixels)
    
    let red:Int = (Int)(avgRed + 0.5)
    let green:Int = (Int)(avgGreen + 0.5)
    let blue:Int = (Int)(avgBlue + 0.5)
    
    
    rgbValues = "Average Red: \(red)\nAverage Green: \(green)\nAverage Blue: \(blue)\n"
    
    return rgbValues
}
