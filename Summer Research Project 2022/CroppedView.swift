//
//  CroppedView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/22/22.
//

import SwiftUI

struct CroppedView: View {
    var testResults: results!
    var body: some View {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        ZStack {
            Color("Turquoise")
                            .ignoresSafeArea()
            
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 7/8, height: (screenHeight * 4/5))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                Text("Top Left: \(testResults.test1Left)")
                Text("Top Right: \(testResults.test1Right)")
                Text("Middle Left: \(testResults.test2Left)")
                Text("Middle Right: \(testResults.test2Right)")
                Text("Bottom Left: \(testResults.test3Left)")
                Text("Bottom Right: \(testResults.test3Right)")
                Spacer()
                NavigationLink{
                    ContentView()
                }
            label:{
                Image("home button")
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 60.0, height: 60.0)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                   // .position(x: screenWidth/2, y: (screenHeight/16))
                }
            }
            
        }.accentColor(.black)

    }
}

struct CroppedView_Previews: PreviewProvider {
    static var previews: some View {
        CroppedView()
    }
}
