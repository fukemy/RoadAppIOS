//
//  DataItemModel.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "DataItemModel.h"

@implementation DataItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithJSONString:(NSString *)JSONString
{
    self = [super init];
    if (self) {
        
        NSError *error = nil;
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        arr = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        
        if (!error && arr) {
            //Loop method
            for (NSDictionary* dict in arr) {
                [self setValuesForKeysWithDictionary:dict];

            }
        }
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
            [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
