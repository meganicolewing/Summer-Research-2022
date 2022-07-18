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
                ZStack{
                    VStack {
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
