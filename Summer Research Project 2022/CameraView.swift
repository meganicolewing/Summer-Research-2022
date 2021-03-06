//
//  CameraView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/17/22.
//

import SwiftUI

struct CameraView: View {
    //determines whether the popup asking the user if they want to use photo library or the camera is displayed
    @State private var showSheet: Bool = false
    //determines whether the view showing either the photo library or camera is displayed
    @State private var showImagePicker: Bool = false
    //holds information on if the user selected photo library or camera
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    //holds the image
    @State private var rotatedImage: UIImage!
    @State private var image: UIImage!
    @State private var edges: UIImage!
    @State private var readyToContinue: Bool = false
    @State private var errorFound:Bool = false
    @State private var testResults: results! = results()

    //for the navigation - is true when the image variable holds an image and false otherwise
    private var imageUploaded:Bool {
        if image == nil{
            return false
        }
        else{
            return true
        }
    }
    
    var body: some View {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        
        ZStack{
            Color("Turquoise")
                            .ignoresSafeArea()
            
            Image("white")
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 7/8, height: (screenHeight * 4/5))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            
            VStack{
                Rectangle()
                    .frame(width: screenWidth, height: screenHeight/16)
                    .opacity(0)
                Spacer()

                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: screenWidth * 7/8, height: (screenHeight/2))
                
//                    .opacity(imageUploaded ? 1:0)
                
                Button(action: {
                    
                    self.showSheet = true
                    
                }, label: {
                   
                    Image("Choose an Image")
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 175.0, height: 60.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                   
                    
                }).padding()
                Button(action: {
                    rotatedImage = unrotateImage(image) //rotate(image, image.imageOrientation)
                    edges = DetectEdgesWrapper().detectFunction(rotatedImage)
                    testResults = getNewLimits(edges, rotatedImage)
                    if testResults.test1Left == -1 {
                        errorFound = true
                    }
                    else {
                        readyToContinue = true
                    }
                }, label: {
                    Image("Continue")
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 175.0, height: 60.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                })
                .opacity(imageUploaded ? 1:0)
                //used to display the view asking if the user would like to use an image from library or use the camera
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Select Photo"),
                            message: Text("Choose a photo to analyze :)"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                                
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                                
                            },
                            .cancel()
                        ])
                }
                Spacer()

                NavigationLink("Continue               ",
                               destination: intermediateView(rectangleStruct:testResults, edges: edges, image: rotatedImage),
                               isActive: $readyToContinue)
                    .opacity(0)
                NavigationLink("error",
                               destination: ErrorView(),
                               isActive: $errorFound)
                .opacity(0)

                Spacer()
                
                //home button
                NavigationLink{
                    ContentView()
                }
            label:{
                Image("home button")
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 60.0, height: 60.0)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .position(x: screenWidth/2, y: (screenHeight/32))
                }
                

                
            }.navigationBarTitle("Upload Your Test", displayMode: .inline)

            
        //used to display either the photo library or the camera
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
        }.accentColor(.black)
    }
}

struct ChooseTestView: View {
    var body: some View {
        VStack{
            
        }
    }
}

struct CameraView_Previews: PreviewProvider {
   static var previews: some View {
       CameraView()
    }
}
