//
//  PastTestsView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/17/22.
//

import SwiftUI

struct PastTestsView: View {
    var dates = ["01/01/01 - 2:56 P.M.", "04/03/22 - 4:20 A.M.", "06/23/33 - Ur Mom O'Clock"]

    var results = ["Positive for ur mom", "Positive for deez nuts fhdsjkalfdsa", "Negative for COVID-19"]

    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        
        ZStack{
            
            Color("Turquoise")
                            .ignoresSafeArea()
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: 345.0, height: (screenHeight - 190))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2))
            
            Image("logo")
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2 - 325))
            
            
            Text("Past Tests")
                .fontWeight(.bold)
                .padding(.bottom)
                .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility2/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2 - 225))
        
            ScrollView{
                
                LazyVGrid(columns: gridItemLayout, spacing: 20){
                    Text("Date and Time").fontWeight(.bold).multilineTextAlignment(.center)
                    Text("Result").fontWeight(.bold).multilineTextAlignment(.center)
                    ForEach((0...dates.count - 1), id: \.self){
                        Text(dates[$0 % dates.count])
                            .multilineTextAlignment(.leading)
                            .padding(.all)
                            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                            .cornerRadius(20)
                            .frame(width: 150, height: 100)
                        Text(results[$0 % results.count])
                            .multilineTextAlignment(.leading)
                            .padding(.all)
                            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.913))
                            .cornerRadius(20)
                            .frame(width: 150, height: 100)
                                        
                    }
                    
                    
                }
                
            }.padding(.horizontal)
                .padding(.bottom)
                .position(x: screenWidth/2 - 10, y: (screenHeight/2 - 20))
                .frame(width: screenWidth - 20, height: (screenHeight-300))
            
            NavigationLink{
                ContentView()
            }
        label:{
            Image("home button")
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(width: 60.0, height: 60.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .position(x: screenWidth/2, y: (screenHeight/2 + 325))
            }
            
                
        
        }
    }
}

struct PastTestsView_Previews: PreviewProvider {
    static var previews: some View {
        PastTestsView()
    }
}
