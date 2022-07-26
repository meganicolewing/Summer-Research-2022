//
//  rotateUIImage.m
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/26/22.
//
#import "rotateUIImage.h"

//static inline double radians (double degrees) {return degrees * M_PI/180;}
//UIImage* rotate(UIImage* src, UIImageOrientation orientation)
//{
//    UIGraphicsBeginImageContext(src.size);
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    if (orientation == UIImageOrientationRight) {
//        CGContextRotateCTM (context, radians(90));
//    } else if (orientation == UIImageOrientationLeft) {
//        CGContextRotateCTM (context, radians(-90));
//    } else if (orientation == UIImageOrientationDown) {
//        CGContextRotateCTM (context, radians(180));
//
//    } else if (orientation == UIImageOrientationUp) {
//        //NOTHING
//    }
//
//    [src drawAtPoint:CGPointMake(0, 0)];
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

UIImage* unrotateImage(UIImage* image)
{
    CGSize size = image.size;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width ,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}
