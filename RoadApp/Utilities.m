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
#import <GoogleMaps/GoogleMaps.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Constant.h"

@implementation Utilities

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)colorwithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
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

+(NSString *)dateStringFromTimeStamp:(NSString *)timeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    return [formatter stringFromDate:date];
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

+ (void) showSimpleAlert:(NSString *)message atViewController:(UIViewController *)controller
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [controller presentViewController:alert animated:YES completion:nil];
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


+(void)getLocationByCoor:(CLLocation *)loc success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *strAdd = nil;
            
            if ([placemark.subThoroughfare length] != 0)
                strAdd = placemark.subThoroughfare;
            
            if ([placemark.thoroughfare length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                else
                {
                    strAdd = placemark.thoroughfare;
                }
            }
            
            if ([placemark.postalCode length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                else
                    strAdd = placemark.postalCode;
            }
            
            if ([placemark.locality length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                else
                    strAdd = placemark.locality;
            }
            
            if ([placemark.administrativeArea length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                else
                    strAdd = placemark.administrativeArea;
            }
            
            if ([placemark.country length] != 0)
            {
                if ([strAdd length] != 0)
                    strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                else
                    strAdd = placemark.country;
            }
            success(strAdd);
        } else {
            failure(error);
            NSLog(@"find location error: %@", error.debugDescription);
        }
    }];

}

+ (void) sizeLabel: (UILabel *) label toRect: (CGRect) labelRect {
    
    // Set the frame of the label to the targeted rectangle
    label.frame = labelRect;
    
    // Try all font sizes from largest to smallest font size
    int fontSize = 300;
    int minFontSize = 5;
    
    // Fit label width wize
    CGSize constraintSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    
    do {
        // Set current font size
        label.font = [UIFont fontWithName:label.font.fontName size:fontSize];
        
        // Find label size for current font size
        CGRect textRect = [[label text] boundingRectWithSize:constraintSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName: label.font}
                                                     context:nil];
        
        CGSize labelSize = textRect.size;
        
        // Done, if created label is within target size
        if( labelSize.height <= label.frame.size.height)
            break;
        
        // Decrease the font size and try again
        fontSize -= 2;
        
    } while (fontSize > minFontSize);
}

+ (void)getPhotoByPath:(NSString *)path success:(void (^)(UIImage *responseObject))success failure:(void (^)(NSError *error))failure{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSURL* aURL = [NSURL URLWithString:path];
    [library assetForURL:aURL resultBlock:^(ALAsset *asset)
     {
         UIImage *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1 orientation:UIImageOrientationUp];
         success(copyOfOriginalImage);
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----: %@", [error localizedDescription]);
     }];
}

+ (NSMutableArray *)getSectionListItem{
    NSString *itemDataString = [[NSUserDefaults standardUserDefaults] objectForKey:ITEM_DATA_LIST];
    
    NSError *error = nil;
    
    NSData *JSONData = [itemDataString dataUsingEncoding:NSUTF8StringEncoding];
    if(JSONData == nil){
        return [[NSMutableArray alloc] init];
    }else{
        return [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
    }
}
@end
