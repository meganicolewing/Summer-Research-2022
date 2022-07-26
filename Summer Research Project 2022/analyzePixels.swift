//
//  analyzePixels.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/21/22.
//

import Foundation
import SwiftUI
import UIKit

//averages RGB values across box in image, returns an int containing the average saturation value
// box - testBox with the coordinates of the corners of a box to be analyzed in image
//for more notes on the struct testBox, see "TestFinder.swift"
func analyzePixels(_ image: UIImage, /* _ numList: inout [Int], */ _ box: testBox) -> [CGRect] {
    //acesses image data to process
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    var xStart = box.xMin
    var xEnd = box.xMax
    var yStart = box.yMin
    var yEnd = box.yMax
    if box.xMax == -1
    {
        xStart = 0
        xEnd = cgImage.width
        yStart = 0
        yEnd = cgImage.height
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
    
    var pixelsDetected:[CGRect] = []
    
    //ensures the image wil be read as RGB pixels
    assert(cgImage.colorSpace?.model == .rgb)
    //used to parse through the array of image pixels and find RGB values
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent

    //goes through each pixel of the image in the box and adds the RGB values to the appropriate variable
    for y in yStart ..< yEnd {
        for x in xStart ..< xEnd {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            // find the current RGB values
            currRed = (Double(bytes[offset]))
            currBlue = (Double(bytes[offset + 2]))
            currGreen = (Double(bytes[offset + 1]))
            
            print("[" + String(x) + ", " + String(y) + "]: ")
            print("Red: ", currRed)
            print("Green: ", currGreen)
            print("Blue: ", currBlue)
            
            //Converts x and y coordinates to UI coordinates
            
            //Draws pixel on top of current pixel
            pixelsDetected.append(CGRect(x: Double(x)/Double(cgImage.width), y: Double(y)/Double(cgImage.height), width: Double(1)/Double(cgImage.width), height: Double(1)/Double(cgImage.height)))
            
            // finds the max and min RGB values, then checks them to make sure they are different enough that the pixel isn't grayscle, ensuring that the inside of the test is being picked up, rather than the outline of the test
            currMax = max(currRed, currGreen, currBlue)
            currMin = min(currRed, currGreen, currBlue)
          //  if (currMax - currMin) > 50 {
                // adds the values to the average if the the pixel is suitable
                avgRed = (currRed + avgRed)
                avgGreen = (currGreen + avgGreen)
                avgBlue = (currBlue + avgBlue)
                numPixels += 1
           // }
        }
    }
    
    // Find the average red, blue, and green value for the specified area
    avgRed = avgRed / Double(numPixels)
    avgGreen = avgGreen / Double(numPixels)
    avgBlue = avgBlue / Double(numPixels)
    
    // rounding
    let red:Int = (Int)(avgRed + 0.5)
    let green:Int = (Int)(avgGreen + 0.5)
    let blue:Int = (Int)(avgBlue + 0.5)
    
    // Alter the list for the values with those ones calculated in lines 59-61
    // This lets us have both a string to print AND a list of values for us to access directly
   
    //numList[0] = red
    //numList[1] = green
    //numList[2] = blue
    
    //reduce the RGB values to 0-1
    let rPrime = Double(red)/255
    let gPrime = Double(green)/255
    let bPrime = Double(blue)/255
    
    //find saturation from reduced RGB values
    let cMax = max(rPrime, gPrime, bPrime)
    let cMin = min(rPrime, gPrime, bPrime)
    let delta = cMax - cMin
    var saturation:Double = 0
    if cMax != 0 {
        saturation = (delta / cMax) * 100
    }
    
    let reducedSat = Int(saturation + 0.5)
    
    // Human-readable string for printig purposes
    //rgbValues = "Average Red: \(red)\nAverage Green: \(green)\nAverage Blue: \(blue)\n"
    print("Average Red: \(red)\nAverage Green: \(green)\nAverage Blue: \(blue)")
    
    return pixelsDetected
}
