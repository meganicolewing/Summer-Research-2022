//
//  intermediateView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/13/22.
//

import SwiftUI

struct intermediateView: View {
    var rectangleStruct:results!
    var edges: UIImage!
    var image: UIImage!
    var rectangles: results!
    @State private var readyToContinue:Bool = false
    @State private var errorFound:Bool = false
    @State private var testResults: results!
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
                Rectangle()
                    .frame(width: screenWidth, height: screenHeight/16)
                    .opacity(0)
                Spacer()
                Image(uiImage: edges)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: screenWidth * 7/8, height: (screenHeight/2))
    //                .overlay(
    //                    GeometryReader { geometry in
    //
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles1Left.minX *  geometry.size.width + 6,
    //                                y: rectangleStruct.rectangles1Left.minY *  geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles1Left.width *  geometry.size.width,
    //                                height: rectangleStruct.rectangles1Left.height *  geometry.size.height))
    //                                .stroke(.white, lineWidth: 2)
    //                                .background(Rectangle().fill(.black))
    //
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles1Right.minX *  geometry.size.width - 6,
    //                                y: rectangleStruct.rectangles1Right.minY *  geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles1Right.width *  geometry.size.width,
    //                                height: rectangleStruct.rectangles1Right.height *  geometry.size.height))
    //
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles2Left.minX *  geometry.size.width + 6,
    //                                y: rectangleStruct.rectangles2Left.minY *  geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles2Left.width *  geometry.size.width,
    //                                height: rectangleStruct.rectangles2Left.height *  geometry.size.height))
    //                                .stroke(Color.red, lineWidth: 1)
    //                                .background(Color.white)
    //                    }).overlay(
    //                    GeometryReader { geometry in
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles2Right.minX *  geometry.size.width - 6,
    //                                y: rectangleStruct.rectangles2Right.minY *  geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles2Right.width *  geometry.size.width,
    //                                height: rectangleStruct.rectangles2Right.height *  geometry.size.height))
    //                                .stroke(Color.red, lineWidth: 1)
    //                                .background(Color.white)
    //
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles3Left.minX * geometry.size.width + 6,
    //                                y: rectangleStruct.rectangles3Left.minY * geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles3Left.width * geometry.size.width,
    //                                height: rectangleStruct.rectangles3Left.height * geometry.size.height))
    //                                .stroke(Color.red, lineWidth: 1)
    //                                .background(Color.white)
    //
    //                            Rectangle()
    //                                .path(in: CGRect(
    //                                x: rectangleStruct.rectangles3Right.minX *  geometry.size.width - 6,
    //                                y: rectangleStruct.rectangles3Right.minY *  geometry.size.height + 2,
    //                                width: rectangleStruct.rectangles3Right.width *  geometry.size.width,
    //                                height: rectangleStruct.rectangles3Right.height *  geometry.size.height))
    //                                .stroke(Color.red, lineWidth: 1)
    //                                .background(Color.white)
    //
    //                    })
                Spacer()
                Button(action: {
                        readyToContinue = true
                }, label: {
                    Image("Continue")
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 175.0, height: 60.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                })
                NavigationLink(destination: CroppedView(testResults: rectangleStruct), isActive: $readyToContinue, label: {
                    Text("Continue")
                        .opacity(0)
                })
                NavigationLink("error",
                               destination: ErrorView(),
                               isActive: $errorFound)
                .opacity(0)
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
                    .position(x: screenWidth/2, y: (screenHeight/8))
                }
            }

        }.accentColor(.black)

    }
}

/*struct intermediateView_Previews: PreviewProvider {
    static var previews: some View {
        intermediateView()
    }
}*/
