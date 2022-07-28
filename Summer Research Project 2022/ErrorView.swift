//
//  ErrorView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/26/22.
//

import SwiftUI

struct ErrorView: View {
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
            VStack {
                Spacer()
                Text("There was an error processing your test.\nPlease take a new picture and try again.")
                    .padding()
                    .navigationBarTitle("Oops... Something Went Wrong")
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
                   // .position(x: screenWidth/2, y: (screenHeight))
                }
            }

        }.accentColor(.black)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
