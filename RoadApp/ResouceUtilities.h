//
//  ResouceUtilities.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ResouceUtilities : NSObject

+ (NSString* ) plistNameFromCategory:(int )categoryId;
+ (int ) getDataTypeByItemId:(int )itemId;
+ (UIImage *)getItemBackground:(int) order;
@end
