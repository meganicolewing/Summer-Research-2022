//
//  DetectEdges.cpp
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/11/22.
//
#import "PrefixHeader.pch"
#include "DetectEdges.hpp"

#import "opencv2/core.hpp"
#import "opencv2/highgui.hpp"
#import "opencv2/imgproc.hpp"
#include "opencv2/imgcodecs.hpp"
#include <UIKit/UIKit.h>
#import <SwiftUI/SwiftUI.h>
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#include "opencv2/imgcodecs/ios.h"
#import <Foundation/Foundation.h>

using namespace std;
using namespace cv;

// *gray - pointer to a Mat holding data from an image that has been converted to grayscale
// *blurred - pointer to a Mat object that will be filled with a blurred version of the grayscale Mat
// *edge - pointer to a Mat object that will be filled with data for an image showing just the edges detected from Canny
// takes these Mat pointers and passes them into OpenCV functions to detect the edges
//returns nothing
void CannyThreshold(cv::Mat *gray, cv::Mat *blurred, cv::Mat *edge);

// *image - pointer to a UIImage that will be run through Canny to find the edges
// converts the UIImage to a format readable by OpenCV, converts it to grayscale, and calls CannyThreshold
// converts the *edge from CannyThreshold back to a UIImage and returns that
UIImage* DetectEdgesClass::DetectFunction(UIImage *image) {
    cv::Mat img;
    UIImageToMat(image, img);
    cv::Mat gray, blurred, edge;

    //Mat img = imread("test.png");
    cv::cvtColor(img, gray, cv::COLOR_BGR2GRAY);
    CannyThreshold(&gray, &blurred, &edge);
    UIImage *edges = MatToUIImage(edge);
    return edges;
}

void CannyThreshold(cv::Mat *gray, cv::Mat *blurred, cv::Mat *edge) {
    GaussianBlur(*gray,              //input
                 *blurred,           //output
                 cv::Size(9,9),     //smoothing window in pixels
                 7);                //houw much the image will be blurred
    
    Canny(*blurred,                  //input
          *edge,                     //output
          50,                       //lower threshold
          140);                       //higher threshold
    
}

