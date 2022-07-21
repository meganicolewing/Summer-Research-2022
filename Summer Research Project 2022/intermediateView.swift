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
    var rectangles: results!
    @State private var readyToContinue:Bool = false
    @State private var testResults: results!
    var body: some View {
        VStack {
            Image(uiImage: edges)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            /*
                .overlay(
                    GeometryReader { geometry in
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test1Left.minX*geometry.size.width,
                                y: rectangles.test1Left.minY*geometry.size.height,
                                width: rectangles.test1Left.width*geometry.size.width,
                                height: rectangles.test1Left.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test1Right.minX*geometry.size.width,
                                y: rectangles.test1Right.minY*geometry.size.height,
                                width: rectangles.test1Right.width*geometry.size.width,
                                height: rectangles.test1Right.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test2Left.minX*geometry.size.width,
                                y: rectangles.test2Left.minY*geometry.size.height,
                                width: rectangles.test2Left.width*geometry.size.width,
                                height: rectangles.test2Left.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test2Right.minX*geometry.size.width,
                                y: rectangles.test2Right.minY*geometry.size.height,
                                width: rectangles.test2Right.width*geometry.size.width,
                                height: rectangles.test2Right.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test3Left.minX*geometry.size.width,
                                y: rectangles.test3Left.minY*geometry.size.height,
                                width: rectangles.test3Left.width*geometry.size.width,
                                height: rectangles.test3Left.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                        Rectangle()
                            .path(in: CGRect(
                                x: rectangles.test3Right.minX*geometry.size.width,
                                y: rectangles.test3Right.minY*geometry.size.height,
                                width: rectangles.test3Right.width*geometry.size.width,
                                height: rectangles.test3Right.height*geometry.size.height))
                            .stroke(Color.red, lineWidth: 1.0)
                    })
             */
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
