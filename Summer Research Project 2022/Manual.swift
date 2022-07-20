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
            Color("Main_Yellow")
                            .ignoresSafeArea()
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: 345.0, height: (screenHeight - 170))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2 - 75))
            VStack {
                Spacer()
                Text("Instructions")
                    .fontWeight(.bold).padding(.bottom).dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)
                //Spacer()
                Text("Welcome to the RGB Engineers App. ")
                Text("To navigate this app, return to the Home")
                Text("Page you entered on. To take a picture of a")
                Text("test, navigate to the \"Analyze a Sample\"")
                Text("screen. To view previous results, navigate to")
                Text("the \"View Past Tests\" screen.")
                    .padding(.bottom)
                
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Home")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(Color("Main_Yellow"))
                        .cornerRadius(20)
                        .padding()
                }
                Spacer()
            }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct Manual_Previews: PreviewProvider {
    static var previews: some View {
        Manual()
    }
}
