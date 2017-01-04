//
//  Utilities.h
//  RoadApp
//
//  Created by devil2010 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "btRippleButtton.h"
#import "SlideNavigationController.h"
#import "ReportScreenViewCell.h"
#import "VCFloatingActionButton.h"


@interface Utilities : NSObject
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (NSString *)removeString:(NSString *)str byCharacter:(NSString *)character;
+ (UIImage *)getItemBackground:(int) order;
+ (void)shakeView:(UIView *)view withInfinity:(BOOL)isInfinity;
+ (NSString *) generateUUID;
+ (NSString *) timeStamp;
+ (NSString *) dateStringFromTimeStamp:(NSString *)timeStamp;
+ (NSMutableDictionary* ) dataFromPlist:(int )itemID;
+ (int ) getDataTypeByItemId:(int )itemId;
+ (void) toString:(NSObject *)object;
+ (void) showSimpleAlert:(NSString *)message atViewController:(UIViewController *)controller;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)enableDismissKeyboardByClickInView:(UIViewController*)controller;
+ (void) showViewWithScaleAnim:(UIView *)view;
+ (void) hideViewWithScaleAnim:(UIView *)view;
+ (void)getLocationByCoor:(CLLocation *)loc success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void) sizeLabel: (UILabel *) label toRect: (CGRect) labelRect;
+ (void)getPhotoByPath:(NSString *)path success:(void (^)(UIImage *responseObject))success failure:(void (^)(NSError *error))failure;
@end
