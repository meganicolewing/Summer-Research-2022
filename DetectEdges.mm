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

void CannyThreshold(cv::Mat *gray, cv::Mat *blurred, cv::Mat *edge);

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
                 cv::Size(3,3),     //smoothing window in pixels
                 3);                //houw much the image will be blurred
    
    Canny(*blurred,                  //input
          *edge,                     //output
          55,                         //lower threshold
          160);                      //higher threshold
    
}

