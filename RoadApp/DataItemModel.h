//
//  DataItemModel.h
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItemModel : NSObject

@property long ItemID;
@property NSString *ItemName;
@property NSString *Description;

- (instancetype)initWithJSONString:(NSString *)JSONString;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
