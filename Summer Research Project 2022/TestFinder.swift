//
//  TestFinder.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/12/22.
//

import Foundation
import SwiftUI
import UIKit

// struct used to hold coordinates of the four corners of a box within an image
struct testBox {
    var xMin:Int = -1
    var xMax:Int = -1
    var yMin:Int = -1
    var yMax:Int = -1
    // intiates a testBox using information collected about the bulb of a test
    // coords - coordinates of the edge of the bulb
    // radius - half the length of one side of the box
    // left - boolean determining if the box is on the right or left of the image - helps ensure xMin and xMax are appropriately assigned
    init(coords: [Int], radius: Int, left: Bool) {
        // y-coordinates go the radius up and down from the detected coordinate
        yMin = coords[1] - radius
        yMax = coords[1] + radius
        // if the bulb is on the left of the image, we add to move further into the image
        if left {
            // add one radius to get the left side of the box, within the test bulb
            xMin = coords[0] + radius
            // add three radiuses to get the right side of the box, within the test bulb
            xMax = coords[0] + (radius * 3)
        }
        // if the bulb is on the right of the image, we subtract to move further into the image
        else {
            xMin = coords[0] - (radius * 3)
            xMax = coords[0] - radius
        }
    }
}

// holds saturation data about all six bulbs in a test
struct results {
    // test 1 is the bottom test, while test 3 is the top test
    var test1Left:Double = -1
    var test1Right:Double = -1
    var test2Left:Double = -1
    var test2Right:Double = -1
    var test3Left:Double = -1
    var test3Right:Double = -1
}

// image - pointer to a UIImage, this should be an image that has been returned from an edge detector and contains only the edges of the test
// reverseX - a boolean used to reverse the direction of analysis - default to false to analyze from the left, set to true to analyze from the right
// startY - defaults to -1, which will be changed to 0. used to change how far up the image analysis will start. Helps in finding individual tests
// endY - defaults to -1, which will be changed to the height of the image. Used to change how far up from startY the analysis will go. Helps in finding individual tests
// returns [Int], and array of ints holding the coordinates [x,y] of the detected edge of the bulb. if the edge is not detected, returns [-1] for now
// parses through the given image, using the given parameters, and finds the edge of the bulb. Makes sure to discount any false readings
func testFinder(_ image: UIImage!, _ reverseX:Bool = false, _ startY: Int = -1, _ endY: Int  = -1) -> [Int] {
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    // checks startY and endY to set them if the defaults were left
    var minY = startY
    var maxY = endY
    
    if startY == -1 {
        minY = 0
    }
    if endY == -1 {
        maxY = cgImage.height
    }
    
    // sets startX and endX properly based on reverseX
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
    
    //box to search around the found white pixel to see if you can fine enough to fullfil sentinel
    let searchBoxWidth = sqrt(Double(cgImage.width))/4
    let searchBoxHeight = sqrt(Double(cgImage.height))/4
    
    let searchBoxHeightRadius = searchBoxHeight/2
    
    //ensures the pixels of the image will be read properly
    assert(cgImage.colorSpace?.model == .monochrome)

    //goes through each pixel of the image to see if it is white
    for x in stride(from:startX, through:endX, by: increment) {
        for y in minY ..< maxY {
            let offset = (y * cgImage.bytesPerRow) + (x)
            pixel = Int(bytes[offset])
            // when a white pixel is found, reset the count to one, then set the bounds of the new search box using that pixel and the radius of the search box defined above
            // this is done to ensure that a small error in the edge detection doesn't result in the wrong coordinate being returned
            if pixel > 250
            {
                count = 1
                let x2:Int = Int(x) + Int(searchBoxWidth + 0.5)
                let x1:Int = Int(x)
                let y1:Int = Int(y) - Int(searchBoxHeightRadius + 0.5)
                let y2:Int = Int(y) + Int(searchBoxHeightRadius + 0.5)
                // search within the defined search box to find more white pixels
                for row in x1 ..< x2 {
                    for col in y1 ..< y2 {
                        let innerOffset = (col * cgImage.bytesPerRow) + (row)
                        pixel = Int(bytes[innerOffset])
                        if pixel > 250 {
                            count += 1
                        }
                    }
                }
                //if enough white pixels are found, return the initial coordinate. if not, continue looking through the image to find the correct edge
                if count >= sentinel {
                    return [x,y]
                }
            }
        }
    }
    // if no correct edge is found, return -1. this needs to be changed as it will cause the app to crash
    return [-1]
}

// edges - pointer to a UIImage which should hold the image returned from the edge detector and shows only the edges found in an image
// image - pointer to a UIImage which should be the original image a user has passed in
// uses testFinder (defined above) to find the right and left bulb of each test. then creates a testBox efined above) for each bulb and calls analyzePixels (defined in "analyzePixels.swift") to find the average saturation of each bulb and stores these in a results object (defined above)
// returns the results object
func getNewLimits(_ edges: UIImage!, _ image:UIImage!) -> results {
    guard let cgImage = image.cgImage else {
        fatalError("cannot access image")
    }
    //finds the furthest left and furthest right edges of the test
    let leftCoordinate = testFinder(edges)
    let rightCoordinate = testFinder(edges, true)
    //determines which of the right or left coordaintes refers to the top test
    var topCoordinate = leftCoordinate
    var firstIsLeft:Bool = true
    if rightCoordinate[1] < leftCoordinate[1] {
        topCoordinate = rightCoordinate
        firstIsLeft = false
    }
    // top and bootom coordinates to narrow search range and find the other top coordinate
    let startY = topCoordinate[1] - cgImage.height/20
    let endY = topCoordinate[1] + cgImage.height/20
    // determines if the other top coordinate is on the left or right side
    let startRight:Bool = (leftCoordinate[1] < rightCoordinate[1])
    let nextTopCoordinate = testFinder(edges, startRight, startY, endY)
    print("coordinates: ", topCoordinate, nextTopCoordinate)
    // uses the dimensions of the test to determine how far down to move when searching for the second and third tests
    let lengthOfTest = abs(topCoordinate[1] - nextTopCoordinate[1])
    let bulbHeight = Int((Double(lengthOfTest) * (3/7)) + 0.5)
    let avgY = Int((topCoordinate[1] + nextTopCoordinate[1])/2)
    // new y search limits for all three tests, using the numbers caclulated above
    let start1 = avgY - Int(bulbHeight/2)
    let end1 = start1 + bulbHeight
    let start2 = end1
    let end2 = start2 + bulbHeight
    let start3 = end2
    let end3 = start3 + bulbHeight
    // uses the first coordinates found as the coordinates of the first test
    var test1LeftCoordinates = nextTopCoordinate
    var test1RightCoordinates = topCoordinate
    if firstIsLeft {
        test1LeftCoordinates = topCoordinate
        test1RightCoordinates = nextTopCoordinate
    }
    // call testFinder to find left and right coordinates of the other two tests
    let test2LeftCoordinates = testFinder(edges, false, start2, end2)
    let test2RightCoordinates = testFinder(edges, true, start2, end2)
    let test3LeftCoordinates = testFinder(edges, false, start3, end3)
    let test3RightCoordinates = testFinder(edges, true, start3, end3)
    // uses the first coordinates found to find the total distance between the bulbs
    let xDistance = test1LeftCoordinates[0] - test1RightCoordinates[0]
    let yDistance = test1LeftCoordinates[1] - test1RightCoordinates[1]
    //print("xDist : \(xDistance)\nyDist: \(yDistance)")
    let bulbDistance = sqrt(pow(Double(xDistance), 2) + pow(Double(yDistance), 2))
    //print("bulbDistance: \(bulbDistance)")
    //uses the dimensions of the tests to find how long an individual bulb is
    let bigSquare = bulbDistance * 6/19
    //print("bigSquare : \(bigSquare)")
    // finds a quarter of the length of a bulb. used to find a square within each bulb by going in this distance from each side
    let squareRadius = Int(bigSquare/4)
    //print("square radius: \(squareRadius)")
    // creates testBox objects for each bulb
    let test1LeftBox = testBox(coords: test1LeftCoordinates, radius: squareRadius, left: true)
    let test1RightBox = testBox(coords: test1RightCoordinates, radius: squareRadius, left: false)
    let test2LeftBox = testBox(coords: test2LeftCoordinates, radius: squareRadius, left: true)
    let test2RightBox = testBox(coords: test2RightCoordinates, radius: squareRadius, left: false)
    let test3LeftBox = testBox(coords: test3LeftCoordinates, radius: squareRadius, left: true)
    let test3RightBox = testBox(coords: test3RightCoordinates, radius: squareRadius, left: false)
    // calls the analyzePixels function with the original image and each testBox and stores all the results in a results object to be returned
    var testResults = results()
    testResults.test1Left = analyzePixels(image, test1LeftBox)
    testResults.test1Right = analyzePixels(image, test1RightBox)
    testResults.test2Left = analyzePixels(image, test2LeftBox)
    testResults.test2Right = analyzePixels(image, test2RightBox)
    testResults.test3Left = analyzePixels(image, test3LeftBox)
    testResults.test3Right = analyzePixels(image, test3RightBox)
    return testResults
}
