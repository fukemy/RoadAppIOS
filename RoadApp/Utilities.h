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
@end
