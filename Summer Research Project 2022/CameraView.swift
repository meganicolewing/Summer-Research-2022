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
    @State private var image: UIImage!
    @State private var edges: UIImage!
    @State private var readyToContinue: Bool = false
    @State private var testResults: results!

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
        
            VStack{
                
                Spacer()
                
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .opacity(imageUploaded ? 1:0)
                
                Button(action: {
                    
                    self.showSheet = true
                    
                }, label: {
                   
                    Text("Choose an Image")
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                   
                    
                }).padding()
                Button(action: {
                    edges = DetectEdgesWrapper().detectFunction(image)
                    testResults = getNewLimits(edges, image)
                    readyToContinue = true
                }, label: {
                    Text("Continue               ")
                })
                
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
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
                               destination: intermediateView(edges: edges, image: image),
                               isActive: $readyToContinue)
                    .opacity(0)
                Spacer()
                

                
            }.navigationBarTitle("Upload Your Test", displayMode: .inline)
            
        //used to display either the photo library or the camera
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
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
