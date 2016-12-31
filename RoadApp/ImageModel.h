//
//  ImageModel.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property NSString *DataID;
@property NSString *ImageName;
@property NSString *ImageDataByte;
- (instancetype)initWithJSONString:(NSString *)JSONString;
@end
