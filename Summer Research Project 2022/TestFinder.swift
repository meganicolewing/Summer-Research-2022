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

struct results {
    var test1Left:Double = -1
    var test1Right:Double = -1
    var test2Left:Double = -1
    var test2Right:Double = -1
    var test3Left:Double = -1
    var test3Right:Double = -1
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
    var endX = cgImage.width - 1
    var increment = 1
    
    if reverseX {
        startX = cgImage.width - 1
        endX = 0
        increment = -1
    }
    
    //rgb values in the loop
    var pixel = 0
    //count for number of pixels in a search box
    var count = 0
    //number of white pixels needed in the search box
    let sentinel = 10 //figure out proportion of this to image size
    
    //box to search around the found white pixel to see if you can fine enought to fullfil sentinel
    let searchBoxWidth = sqrt(Double(cgImage.width))/4
    let searchBoxHeight = sqrt(Double(cgImage.height))/4
    
    let searchBoxHeightRadius = searchBoxHeight/2
    
    assert(cgImage.colorSpace?.model == .monochrome)

    //goes through each pixel of the image and adds the RGB values to the appropriate variable
    for x in stride(from:startX, through:endX, by: increment) {
        for y in minY ..< maxY {
            let offset = (y * cgImage.bytesPerRow) + (x)
            pixel = Int(bytes[offset])
            if pixel > 250
            {
                count = 1
                let x2:Int = Int(x) + Int(searchBoxWidth + 0.5)
                let x1:Int = Int(x)
                let y1:Int = Int(y) - Int(searchBoxHeightRadius + 0.5)
                let y2:Int = Int(y) + Int(searchBoxHeightRadius + 0.5)
                for row in x1 ..< x2 {
                    for col in y1 ..< y2 {
                        let innerOffset = (col * cgImage.bytesPerRow) + (row)
                        pixel = Int(bytes[innerOffset])
                        if pixel > 250 {
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


func getNewLimits(_ edges: UIImage!, _ image:UIImage!) -> results {
    guard let cgImage = image.cgImage else {
        fatalError("cannot access image")
    }
    let leftCoordinate = testFinder(edges)
    let rightCoordinate = testFinder(edges, true)
    var topCoordinate = leftCoordinate
    var firstIsLeft:Bool = true
    if rightCoordinate[1] < leftCoordinate[1] {
        topCoordinate = rightCoordinate
        firstIsLeft = false
    }
    let startY = topCoordinate[1] - cgImage.height/20
    let endY = topCoordinate[1] + cgImage.height/20
    let startRight = (leftCoordinate[1] < rightCoordinate[1])
    let nextTopCoordinate = testFinder(edges, startRight, startY, endY)
    print("coordinates: ", topCoordinate, nextTopCoordinate)
    let lengthOfTest = abs(topCoordinate[1] - nextTopCoordinate[1])
    let bulbHeight = Int((Double(lengthOfTest) * (3/7)) + 0.5)
    let avgY = Int((topCoordinate[1] + nextTopCoordinate[1])/2)
    let start1 = avgY - Int(bulbHeight/2)
    let end1 = start1 + bulbHeight
    let start2 = end1
    let end2 = start2 + bulbHeight
    let start3 = end2
    let end3 = start3 + bulbHeight
    var test1LeftCoordinates = nextTopCoordinate
    var test1RightCoordinates = topCoordinate
    if firstIsLeft {
        test1LeftCoordinates = topCoordinate
        test1RightCoordinates = nextTopCoordinate
    }
    let test2LeftCoordinates = testFinder(edges, false, start2, end2)
    let test2RightCoordinates = testFinder(edges, true, start2, end2)
    let test3LeftCoordinates = testFinder(edges, false, start3, end3)
    let test3RightCoordinates = testFinder(edges, true, start3, end3)
    let xDistance = test1LeftCoordinates[0] - test1RightCoordinates[0]
    let yDistance = test1LeftCoordinates[1] - test1RightCoordinates[1]
    print("xDist : \(xDistance)\nyDist: \(yDistance)")
    let bulbDistance = Int(sqrt(pow(Double(xDistance), 2) + pow(Double(yDistance), 2)))
    print("bulbDistance: \(bulbDistance)")
    let bigSquare = Int(bulbDistance * 6/19)
    print("bigSquare : \(bigSquare)")
    let squareRadius = Int(bigSquare/4)
    print("square radius: \(squareRadius)")
    let test1LeftBox = testBox(coords: test1LeftCoordinates, radius: squareRadius, left: true)
    let test1RightBox = testBox(coords: test1RightCoordinates, radius: squareRadius, left: false)
    let test2LeftBox = testBox(coords: test2LeftCoordinates, radius: squareRadius, left: true)
    let test2RightBox = testBox(coords: test2RightCoordinates, radius: squareRadius, left: false)
    let test3LeftBox = testBox(coords: test3LeftCoordinates, radius: squareRadius, left: true)
    let test3RightBox = testBox(coords: test3RightCoordinates, radius: squareRadius, left: false)
    var testResults = results()
    testResults.test1Left = analyzePixels(image, test1LeftBox)
    testResults.test1Right = analyzePixels(image, test1RightBox)
    testResults.test2Left = analyzePixels(image, test2LeftBox)
    testResults.test2Right = analyzePixels(image, test2RightBox)
    testResults.test3Left = analyzePixels(image, test3LeftBox)
    testResults.test3Right = analyzePixels(image, test3RightBox)
    return testResults
}
