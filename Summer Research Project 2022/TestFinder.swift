//
//  TestFinder.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/12/22.
//

import Foundation
import SwiftUI
import UIKit

struct testBox {
    var xMin:Int = -1
    var xMax:Int = -1
    var yMin:Int = -1
    var yMax:Int = -1
    init(coords: [Int], radius: Int, left: Bool) {
        yMin = coords[1] - radius
        yMax = coords[1] + radius
        if left {
            xMin = coords[0] + radius
            xMax = coords[0] + (radius * 3)
        }
        else {
            xMin = coords[0] - (radius * 3)
            xMax = coords[0] - radius
        }
    }
}
func testFinder(_ image: UIImage!, _ reverseX:Bool = false, _ startY: Int = -1, _ endY: Int  = -1) -> [Int] {
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    var minY = startY
    var maxY = endY
    
    if startY == -1 {
        minY = 0
    }
    if endY == -1 {
        maxY = cgImage.height
    }
    
    var startX = 0
    var endX = cgImage.width
    var increment = 1
    
    if reverseX {
        startX = cgImage.width
        endX = 0
        increment = -1
    }
    
    //rgb values in the loop
    var red:Double = 0
    var green:Double = 0
    var blue:Double = 0
    //count for number of pixels in a search box
    var count = 0
    //number of white pixels needed in the search box
    let sentinel = 30 //figure out proportion of this to image size
    
    //box to search around the found white pixel to see if you can fine enought to fullfil sentinel
    let searchBoxWidth = sqrt(Double(cgImage.width))/4
    let searchBoxHeight = sqrt(Double(cgImage.height))/4
    
    let searchBoxHeightRadius = searchBoxHeight/2
    
    assert(cgImage.colorSpace?.model == .rgb)
    
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent

    //goes through each pixel of the image and adds the RGB values to the appropriate variable
    for x in stride(from:startX, to:endX, by: increment) {
        for y in minY ..< maxY {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            red = (Double(bytes[offset]))
            green = (Double(bytes[offset + 1]))
            blue = (Double(bytes[offset + 2]))
            if red > 250 && green > 250 && blue > 250
            {
                count = 1
                let x2:Int = Int(x) + Int(searchBoxWidth + 0.5)
                let x1:Int = Int(x)
                let y1:Int = Int(y) - Int(searchBoxHeightRadius + 0.5)
                let y2:Int = Int(y) + Int(searchBoxHeightRadius + 0.5)
                for row in x1 ..< x2 {
                    for col in y1 ..< y2 {
                        let innerOffset = (col * cgImage.bytesPerRow) + (row * bytesPerPixel)
                        red = (Double(bytes[innerOffset]))
                        green = (Double(bytes[innerOffset + 1]))
                        blue = (Double(bytes[innerOffset + 2]))
                        if red > 250 && green > 250 && blue > 250 {
                            count += 1
                        }
                    }
                }
                if count >= sentinel {
                    return [x,y]
                }
            }
        }
    }
    return [-1]
}


func getNewLimits(_ image:UIImage!) {
    guard let cgImage = image.cgImage else {
        fatalError("cannot access image")
    }
    let leftCoordinate = testFinder(image)
    let rightCoordinate = testFinder(image, true)
    var topCoordinate = leftCoordinate
    if rightCoordinate[1] < leftCoordinate[1] {
        topCoordinate = rightCoordinate
    }
    let startY = topCoordinate[1] - cgImage.height/20
    let endY = topCoordinate[1] + cgImage.height/20
    let startRight = (leftCoordinate[1] < rightCoordinate[1])
    let nextTopCoordinate = testFinder(image, startRight, startY, endY)
    print("coordinates: ", topCoordinate, nextTopCoordinate)
    let lengthOfTest = abs(topCoordinate[1] - nextTopCoordinate[1])
    let bulbHeight = Int((Double(lengthOfTest) * (3/7)) + 0.5)
    let avgY = Int((topCoordinate[1] + nextTopCoordinate[1])/2)
    let start1 = avgY + Int(bulbHeight/2)
    let end1 = start1 - bulbHeight
    let start2 = end1
    let end2 = start2 + bulbHeight
    let start3 = end2
    let end3 = start3 + bulbHeight
    let test1LeftCoordinates = testFinder(image, false, start1, end1)
    let test1RightCoordinates = testFinder(image, true, start1, end1)
    let test2LeftCoordinates = testFinder(image, false, start2, end2)
    let test2RightCoordinates = testFinder(image, true, start2, end2)
    let test3LeftCoordinates = testFinder(image, false, start3, end3)
    let test3RightCoordinates = testFinder(image, true, start3, end3)
    let xDistance = test1LeftCoordinates[0] - test1RightCoordinates[0]
    let yDistance = test1LeftCoordinates[1] - test1RightCoordinates[1]
    let bulbDistance = Int(sqrt(pow(Double(xDistance), 2) + pow(Double(yDistance), 2)))
    let squareRadius = Int(bulbDistance * (6/19) / 4)
    let test1LeftBox = testBox(coords: test1LeftCoordinates, radius: squareRadius, left: true)
    let test1RightBox = testBox(coords: test1RightCoordinates, radius: squareRadius, left: false)
    let test2LeftBox = testBox(coords: test2LeftCoordinates, radius: squareRadius, left: true)
    let test2RightBox = testBox(coords: test2RightCoordinates, radius: squareRadius, left: false)
    let test3LeftBox = testBox(coords: test3LeftCoordinates, radius: squareRadius, left: true)
    let test3RightBox = testBox(coords: test3RightCoordinates, radius: squareRadius, left: false)
}
