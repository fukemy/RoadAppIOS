//
//  ImageModel.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
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

- (instancetype)initWithDictionary:(ImageModel *)dict
{
    self = [super init];
    if (self) {
    }
    return self;
}
@end
