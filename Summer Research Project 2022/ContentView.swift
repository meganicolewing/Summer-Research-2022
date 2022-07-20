//
//  ContentView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/14/22.
//
// Test

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        
        NavigationView{
        ZStack{
            Color("Main_Yellow")
                            .ignoresSafeArea()
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: 345.0, height: (screenHeight - 170))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2 - 75))
            VStack {
                
                Image("logo")
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                Text("RGB Engineers")
                    .fontWeight(.bold).padding(.bottom).dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)

                Spacer()
                NavigationLink {
                    CameraView()
                } label: {
                    Image("Analyze a Sample")
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 290.0, height: 120.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                NavigationLink{
                    PastTestsView()
                }
            label:{
                Image("View Past Tests")
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 290.0, height: 120.0)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                NavigationLink{
                    Manual()
                }
            label:{
                Image("Instructions")
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 175.0, height: 60.0)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                Spacer()
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
            
            
        }
        
        }.navigationBarHidden(true)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
