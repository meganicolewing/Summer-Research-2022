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
        
            NavigationView{
                VStack {
                    Text("Welcome!").fontWeight(.bold).padding(.bottom).dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)
                    Text("Choose an option below:")
                        .padding(.bottom)
                    NavigationLink {
                        CameraView()
                        //SwiftUIView()
                    } label: {
                        Text("Analyze a Sample")
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .padding(.all)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .padding()
                    }
                
                    NavigationLink{
                        PastTestsView()
                    }
                label:{
                    Text("View Past Tests   ")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding()
                    }
                        

                }
            }.navigationBarBackButtonHidden(true).navigationBarHidden(true)
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
