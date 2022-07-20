//
//  intermediateView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/13/22.
//

import SwiftUI

struct intermediateView: View {
    var edges: UIImage!
    var image: UIImage!
    @State private var readyToContinue:Bool = false
    @State private var testResults: results!
    var body: some View {
        VStack {
            Image(uiImage: edges)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Button(action: {
                testResults = getNewLimits(edges, image)
                readyToContinue = true
            }, label: {
                Text("Continue")
            })
            NavigationLink(destination: CroppedView(testResults: testResults), isActive: $readyToContinue, label: {
                Text("Continue")
                    .opacity(0)
            })
        }
    }
}

struct intermediateView_Previews: PreviewProvider {
    static var previews: some View {
        intermediateView()
    }
}
