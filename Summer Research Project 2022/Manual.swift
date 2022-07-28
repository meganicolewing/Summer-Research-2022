//
//  Manual.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/12/22.
//

import SwiftUI

struct Manual: View {
    var body: some View {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        ZStack() {
            Color("Turquoise")
                            .ignoresSafeArea()
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 7/8, height: (screenHeight * 4/5))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
               // .position(x: screenWidth/2, y: (screenHeight/2 - 25))
            
            Image("logo")
                .cornerRadius(20)
                .position(x: screenWidth/2, y: (screenHeight/2 - 360))
            
            VStack {
                
                Spacer()
                Text("\n\n\n\nInstruction Manual")
                    .fontWeight(.bold).padding(.bottom).dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)
                //Spacer()
                Text("Welcome to the RGB Engineers App!\n")
                
                Text("How to properly take a photo")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("[Instructions]")
                    .padding(.bottom)
                
                Text("How to set up phone stand")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("[Instructions]")
                    .padding(.bottom)
                
                Text("How to interpret results")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("[Instructions]")
                    .padding(.bottom)
                
                NavigationLink {
                    ContentView()
                } label: {
                    Image("home button")
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 60.0, height: 60.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .position(x: screenWidth/2, y: (screenHeight/3))
                }
                
            }
        }//.navigationBarHidden(true)
            .accentColor(.black)
    }
}

struct Manual_Previews: PreviewProvider {
    static var previews: some View {
        Manual()
    }
}
