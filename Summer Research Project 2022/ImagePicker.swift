//
//  ImagePicker.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/16/22.
//

import Foundation
import SwiftUI
import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
        _image = image
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        //overlay
//        let overlayView = UIImageView(image:UIImage(named: "overlay.jpg"))
//        let screenSize: CGRect = UIScreen.main.bounds
//        let screenHeight = screenSize.height
//        let screenWidth = screenSize.width
//        let position = CGPoint(x:screenWidth/2, y:screenHeight/2)
//
//        overlayView.layer.position = position
        
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        //overlay
        if sourceType == .camera {
//            picker.cameraOverlayView = overlayView
        }
    
        return picker
    }
}
