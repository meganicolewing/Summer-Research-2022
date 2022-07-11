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
                rgbVals = analyzePixels(analyze)
                testDate = getDate()
                pressedRGB = true
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(20).opacity(pressedRGB ? 0:1)
                Text(rgbVals)
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
