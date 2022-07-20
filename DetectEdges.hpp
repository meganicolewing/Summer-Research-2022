//
//  DetectEdges.hpp
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/11/22.
//

#ifndef DetectEdges_hpp
#define DetectEdges_hpp

#import "PrefixHeader.pch"
#include <stdio.h>
#include <UIKit/UIKit.h>

class DetectEdgesClass {
public:
    // *image - pointer to a UIImage that will be run through Canny to find the edges
    // converts the UIImage to a format readable by OpenCV, converts it to grayscale, and calls CannyThreshold
    // converts the *edge from CannyThreshold back to a UIImage and returns that
    UIImage* DetectFunction(UIImage *image);
};
#endif /* DetectEdges_hpp */
