#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetectEdges.hpp"
#import "DetectEdgesWrapper.h"
#import "PrefixHeader.pch"


// takes code from "DetectEdges.mm" and calls it in using Objective-C protocol rather than C++ protocol, allowing the code to be run from a Swift file
@implementation DetectEdgesWrapper
- (UIImage *)DetectFunction:(UIImage *)image{
    DetectEdgesClass detectEdges;
    return detectEdges.DetectFunction(image);
}
@end
