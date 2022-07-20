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
//analyzePixels *MUST* be called with '&' before the second parameter!!!!
func analyzePixels(_ image: UIImage, /* _ numList: inout [Int], */ _ box: testBox) -> Double {
    //acesses image data to process
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    //used to hold the current value
    var currRed:Double = 0
    var currBlue:Double = 0
    var currGreen:Double = 0
    var currMax:Double = 0
    var currMin:Double = 0
    //used to count up the total values
    var avgRed:Double = 0
    var avgBlue:Double = 0
    var avgGreen:Double = 0
    var numPixels = 0
    //string to add the RGB values to once processing is complete
    //var rgbValues = ""
    
    assert(cgImage.colorSpace?.model == .rgb)

    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent

    //goes through each pixel of the image and adds the RGB values to the appropriate variable
    //editing the 0..<cgImage.height and 0..<cgImage.width allows you to alter what part of the image will be modified.
    for y in box.yMin ..< box.yMax {
        for x in box.xMin ..< box.xMax {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            //let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            currRed = (Double(bytes[offset]))
            currBlue = (Double(bytes[offset + 2]))
            currGreen = (Double(bytes[offset + 1]))
            currMax = max(currRed, currGreen, currBlue)
            currMin = min(currRed, currGreen, currBlue)
            if (currMax - currMin) > 5 {
                avgRed = (currRed + avgRed)
                avgGreen = (currGreen + avgGreen)
                avgBlue = (currBlue + avgBlue)
                numPixels += 1
            }
            //rgbValues = rgbValues + "[x:\(x), y:\(y)] \(components)\n"
        }
    }
    
    // Find the average red, blue, and green value for the specified area
    avgRed = avgRed / Double(numPixels)
    avgGreen = avgGreen / Double(numPixels)
    avgBlue = avgBlue / Double(numPixels)
    
    // Adjust so that the rounding is more accurate
    let red:Int = (Int)(avgRed + 0.5)
    let green:Int = (Int)(avgGreen + 0.5)
    let blue:Int = (Int)(avgBlue + 0.5)
    
    // Alter the list for the values with those ones calculated in lines 59-61
    // This lets us have both a string to print AND a list of values for us to access directly
   
    //numList[0] = red
    //numList[1] = green
    //numList[2] = blue
    
    let rPrime = Double(red)/255
    let gPrime = Double(green)/255
    let bPrime = Double(blue)/255
    
    let cMax = max(rPrime, gPrime, bPrime)
    let cMin = min(rPrime, gPrime, bPrime)
    let delta = cMax - cMin
    var saturation:Double = 0
    if cMax != 0 {
        saturation = (delta / cMax) * 100
    }
    
    // Human-readable string for printig purposes
    //rgbValues = "Average Red: \(red)\nAverage Green: \(green)\nAverage Blue: \(blue)\n"
    print("Average Red: \(red)\nAverage Green: \(green)\nAverage Blue: \(blue)")
    
    return saturation
}
