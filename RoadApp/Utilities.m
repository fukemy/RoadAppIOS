//
//  Utilities.m
//  RoadApp
//
//  Created by devil2010 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "Utilities.h"
#import <UIKit/UIKit.h>
#import "ResouceUtilities.h"
#import "ICHObjectPrinter.h"

@implementation Utilities

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (NSString *)removeString:(NSString *)str byCharacter:(NSString *)character
{
    // get all char of string
    if([str length] > 0){
        for (int i = 0; i < [str length]; i++) {
            str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%C", [str characterAtIndex:i]] withString:@""];
        }
    }
    
    return str;
}

+ (UIImage *)getItemBackground:(int) order
{
    return [ResouceUtilities getItemBackground:order];
}

+ (void)shakeView:(UIView *)view withInfinity:(BOOL)isInfinity
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.1;
    animation.byValue = @(2);
    animation.autoreverses = YES;
    animation.repeatCount = isInfinity ? INFINITY : 10;
    [view.layer addAnimation:animation forKey:@"Shake"];
}

+ (NSString *) generateUUID
{
    return [[NSUUID UUID] UUIDString];
}

+ (NSString *) timeStamp
{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

+ (NSMutableDictionary* ) dataFromPlist:(int )itemID
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[ResouceUtilities plistNameFromCategory:itemID] ofType:@"plist"];
    return[NSMutableDictionary dictionaryWithContentsOfFile:filePath];
}

+ (int ) getDataTypeByItemId:(int )itemId
{
    return [ResouceUtilities getDataTypeByItemId:itemId];
}

+ (void) toString:(NSObject *)object{
    if(!self){
        NSLog(@"Object is nil");
        return;
    }else{
        NSLog(@"Object is %@",[ICHObjectPrinter descriptionForObject:object]);
    }
}

+ (void) showSimpleAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (void)enableDismissKeyboardByClickInView:(UIViewController*)controller
{
    
}

+ (void) showViewWithScaleAnim:(UIView *)view
{
    view.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         view.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:^(BOOL finished){
                         [view setHidden:NO];
                         view.transform = CGAffineTransformIdentity;
                     }];
}

+ (void) hideViewWithScaleAnim:(UIView *)view
{
    view.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }
                     completion:^(BOOL finished){
                         view.transform = CGAffineTransformIdentity;
                         [view setHidden:YES];
                     }];
}
@end
