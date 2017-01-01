//
//  Utilities.h
//  RoadApp
//
//  Created by devil2010 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (NSString *)removeString:(NSString *)str byCharacter:(NSString *)character;
+ (UIImage *)getItemBackground:(int) order;
+ (void)shakeView:(UIView *)view withInfinity:(BOOL)isInfinity;
+ (NSString *) generateUUID;
+ (NSString *) timeStamp;
+ (NSMutableDictionary* ) dataFromPlist:(int )itemID;
+ (int ) getDataTypeByItemId:(int )itemId;
+ (void) toString:(NSObject *)object;
+ (void) showSimpleAlert:(NSString *)message;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)enableDismissKeyboardByClickInView:(UIViewController*)controller;
+ (void) showViewWithScaleAnim:(UIView *)view;
+ (void) hideViewWithScaleAnim:(UIView *)view;
@end
