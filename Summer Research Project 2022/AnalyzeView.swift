//
//  AnalyzeView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/17/22.
//

import SwiftUI
import UIKit

struct AnalyzeView: View {
    
    var analyze: UIImage!
    
    @State var pressedRGB:Bool = false
    @State var pressedSave:Bool = false
    
    @State var rgbVals:String = "\n\n\n"
    @State var testDate:String = ""
    @State var rgbList: [Int] = [0, 0, 0]
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        let now:Date = Date()

        dateFormatter.locale = Locale(identifier: "en_US")
        let creationDate:String = dateFormatter.string(from: now)
        print(creationDate)
        return creationDate
    }
    
    var body: some View {
        VStack {

            Button("Get RGB Values", action:  {
                //analyzePixels *MUST* be called with '&' before the second parameter!!!!
               // rgbVals = analyzePixels(analyze, &rgbList)
                testDate = getDate()
                pressedRGB = true
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(20).opacity(pressedRGB ? 0:1)
                Text("Average Red: \(rgbList[0])\nAverage Green: \(rgbList[1])\nAverage Blue: \(rgbList[2])\n")
                .padding()
                Text(testDate)
                .padding()
            
            HStack {
                Button ("Save Results", action: {
                    pressedSave = true
                }).padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                .cornerRadius(20).opacity(pressedRGB ? 1:0)
                
                NavigationLink("", destination: PastTestsView(), isActive: $pressedSave).opacity(0)
                
                NavigationLink {
                    CameraView()
                } label: {
                    Text("Try Again")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding()
                }.opacity(pressedRGB ? 1:0)
            }
            
            NavigationLink{
                ContentView()
            }
        label:{
            Text("Home")
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(20)
                .padding()
        }.opacity(pressedRGB ? 1:0)
                    
        }.navigationBarTitle("Analyze Your Test")

       
        
    }
}
