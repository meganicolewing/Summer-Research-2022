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
        
        TabView{
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                    //broken atm
                }
            CameraView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Analyze")
                }
            PastTestsView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Past Tests")
                }
            Manual()
                .tabItem {
                    Image(systemName: "book")
                    Text("Instructions")
                }
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
