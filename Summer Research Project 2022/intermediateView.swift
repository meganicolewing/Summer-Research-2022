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
    @State private var readyToContinue:Bool = false
    @State private var testResults: results!
    var body: some View {
        VStack {
            Image(uiImage: edges)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding().overlay(
                    GeometryReader { geometry in
                        ForEach(0..<rectangleStruct.searchBoxes.count){ index in
                            if index % 2 == 0 {
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.searchBoxes[index].minX *  geometry.size.width + 6,
                                    y: rectangleStruct.searchBoxes[index].minY *  geometry.size.height + 2,
                                    width: rectangleStruct.searchBoxes[index].width *  geometry.size.width,
                                    height: rectangleStruct.searchBoxes[index].height *  geometry.size.height))
                                    .stroke(Color.blue, lineWidth: 1)
                            } else {
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.searchBoxes[index].minX *  geometry.size.width - 6,
                                    y: rectangleStruct.searchBoxes[index].minY *  geometry.size.height + 2,
                                    width: rectangleStruct.searchBoxes[index].width *  geometry.size.width,
                                    height: rectangleStruct.searchBoxes[index].height *  geometry.size.height))
                                    .stroke(Color.blue, lineWidth: 1)
                            }
                        }
                    }).overlay(
                        GeometryReader { geometry in
                            ForEach(0..<rectangleStruct.pixelsDetected.count){ index in
                                if index % 2 == 0 {
                                    Rectangle()
                                        .path(in: CGRect(
                                        x: rectangleStruct.pixelsDetected[index].minX *  geometry.size.width + 6,
                                        y: rectangleStruct.pixelsDetected[index].minY *  geometry.size.height + 2,
                                        width: rectangleStruct.pixelsDetected[index].width *  geometry.size.width,
                                        height: rectangleStruct.pixelsDetected[index].height *  geometry.size.height))
                                        .stroke(Color.green, lineWidth: 1)
                                } else {
                                    Rectangle()
                                        .path(in: CGRect(
                                        x: rectangleStruct.pixelsDetected[index].minX *  geometry.size.width - 6,
                                        y: rectangleStruct.pixelsDetected[index].minY *  geometry.size.height + 2,
                                        width: rectangleStruct.pixelsDetected[index].width *  geometry.size.width,
                                        height: rectangleStruct.pixelsDetected[index].height *  geometry.size.height))
                                        .stroke(Color.green, lineWidth: 1)
                                }
                                
                            }
                        }).overlay(
                        GeometryReader { geometry in
                            
                            ForEach(0..<rectangleStruct.rectangles1Left.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles1Left[index].minX *  geometry.size.width,
                                    y: rectangleStruct.rectangles1Left[index].minY *  geometry.size.height,
                                    width: rectangleStruct.rectangles1Left[index].width *  geometry.size.width,
                                    height: rectangleStruct.rectangles1Left[index].height *  geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                            
                            ForEach(0..<rectangleStruct.rectangles1Right.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles1Right[index].minX *  geometry.size.width,
                                    y: rectangleStruct.rectangles1Right[index].minY *  geometry.size.height,
                                    width: rectangleStruct.rectangles1Right[index].width *  geometry.size.width,
                                    height: rectangleStruct.rectangles1Right[index].height *  geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                            
                            ForEach(0..<rectangleStruct.rectangles2Left.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles2Left[index].minX *  geometry.size.width,
                                    y: rectangleStruct.rectangles2Left[index].minY *  geometry.size.height,
                                    width: rectangleStruct.rectangles2Left[index].width *  geometry.size.width,
                                    height: rectangleStruct.rectangles2Left[index].height *  geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                        }).overlay(
                        GeometryReader { geometry in
                            ForEach(0..<rectangleStruct.rectangles2Right.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles2Right[index].minX *  geometry.size.width,
                                    y: rectangleStruct.rectangles2Right[index].minY *  geometry.size.height,
                                    width: rectangleStruct.rectangles2Right[index].width *  geometry.size.width,
                                    height: rectangleStruct.rectangles2Right[index].height *  geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                            
                            ForEach(0..<rectangleStruct.rectangles3Left.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles3Left[index].minX * geometry.size.width,
                                    y: rectangleStruct.rectangles3Left[index].minY * geometry.size.height,
                                    width: rectangleStruct.rectangles3Left[index].width * geometry.size.width,
                                    height: rectangleStruct.rectangles3Left[index].height * geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                            
                            ForEach(0..<rectangleStruct.rectangles3Right.count){ index in
                                Rectangle()
                                    .path(in: CGRect(
                                    x: rectangleStruct.rectangles3Right[index].minX *  geometry.size.width,
                                    y: rectangleStruct.rectangles3Right[index].minY *  geometry.size.height,
                                    width: rectangleStruct.rectangles3Right[index].width *  geometry.size.width,
                                    height: rectangleStruct.rectangles3Right[index].height *  geometry.size.height))
                                    .stroke(Color.red, lineWidth: 1)
                            }
                        })
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

/*struct intermediateView_Previews: PreviewProvider {
    static var previews: some View {
        intermediateView()
    }
}*/
