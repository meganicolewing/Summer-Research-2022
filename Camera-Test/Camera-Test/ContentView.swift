//
//  ContentView.swift
//  Camera-Test
//
//  Created by Dave Toth on 6/17/22.
//

import SwiftUI
import UIKit



let image = UIImage(named: "rgb2.jpg")!

func analyzePixels() -> String {
    guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    
    var avgRed:Double = 0
    var avgBlue:Double = 0
    var avgGreen:Double = 0

    var rgbValues = ""
    assert(cgImage.colorSpace?.model == .rgb)

    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    
    let numPixels:Int = (cgImage.height * cgImage.width)
    
    for y in 0 ..< cgImage.height {
        for x in 0 ..< cgImage.width {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            //let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            avgRed = (Double(bytes[offset]) + avgRed)
            avgGreen = (Double(bytes[offset + 1]) + avgGreen)
            avgBlue = (Double(bytes[offset + 2]) + avgBlue)
            //rgbValues = rgbValues + "[x:\(x), y:\(y)] \(components)\n"
        }
    }
    
    avgRed = avgRed / Double(numPixels)
    avgGreen = avgGreen / Double(numPixels)
    avgBlue = avgBlue / Double(numPixels)
    
    rgbValues = "Average Red: \(avgRed)\nAverage Green: \(avgGreen)\nAverage Blue: \(avgBlue)\n"
    
    return rgbValues
}

struct ContentView: View {
    
    @State var rgbVals:String = ""
    
    var body: some View {
        VStack {
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/, action:  {
                rgbVals = analyzePixels()
            })
            ScrollView {
                Text(rgbVals)
            }
        }
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
