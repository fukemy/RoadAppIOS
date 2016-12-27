//
//  RoadInformationModel.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//



#import "RoadInformationModel.h"

@implementation RoadInformationModel

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
        NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        
        if (!error && JSONDictionary) {
            //Loop method
            for (NSString* key in JSONDictionary) {
                NSLog(@"key: %@ - data: %@", key, [JSONDictionary valueForKey:key]);
                [self setValue:[JSONDictionary objectForKey:key] forKey:key];
            }
            // Instead of Loop method you can also use:
            // thanks @sapi for good catch and warning.
//             [self setValuesForKeysWithDictionary:JSONDictionary];
        }
    }
    return self;
}

@end
