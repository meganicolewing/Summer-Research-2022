//
//  PastTestsView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/17/22.
//

import SwiftUI

struct PastTestsView: View {
    var dates = ["01/01/01 - 2:56 P.M.", "04/03/22 - 4:20 A.M.", "06/23/33 - Ur Mom O'Clock"]

    var results = ["Positive for ur mom", "Positive for deez nuts fhdsjkalfdsafsakjdfhasldjfhadsklfjh", "Negative for COVID-19"]

    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ScrollView{

            LazyVGrid(columns: gridItemLayout, spacing: 20){
                Text("Date and Time").fontWeight(.bold).multilineTextAlignment(.center)
                Text("Result").fontWeight(.bold).multilineTextAlignment(.center)
                ForEach((0...dates.count - 1), id: \.self){
                    Text(dates[$0 % dates.count])
                    Text(results[$0 % results.count])
                }
            /*
            
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
            */
            }
            
        }.padding(.horizontal).padding(.bottom)
        
        
    }
}

struct PastTestsView_Previews: PreviewProvider {
    static var previews: some View {
        PastTestsView()
    }
}
