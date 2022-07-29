//
//  CroppedView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/22/22.
//

import SwiftUI

struct CroppedView: View {
    var testResults: results = results()
    
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
                Text("RGB Values")
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)
                Spacer()
                HStack{
                    Text("Top Left: \(testResults.test1Left)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                    Text("Top Right: \(testResults.test1Right)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                }
                
                HStack{
                    Text("Middle Left: \(testResults.test2Left)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                    Text("Middle Right: \(testResults.test2Right)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                }
                
                HStack{
                    Text("Bottom Left: \(testResults.test3Left)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                    Text("Bottom Right: \(testResults.test3Right)")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                        .cornerRadius(20)
                }
                
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
