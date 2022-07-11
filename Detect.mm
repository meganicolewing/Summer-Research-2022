#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetectEdges.hpp"
#import "DetectEdgesWrapper.h"
#import "PrefixHeader.pch"

@implementation DetectEdgesWrapper
- (UIImage *)DetectFunction:(UIImage *)image{
    DetectEdgesClass detectEdges;
    return detectEdges.DetectFunction(image);
}
@end
