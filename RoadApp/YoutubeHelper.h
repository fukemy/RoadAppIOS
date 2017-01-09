//
//  YoutubeHelper.h
//  RoadApp
//
//  Created by devil2010 on 1/9/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YOUTUBE_CHANNEL_ID @"UCWvYziaaakg7jCWgtSprTSw"
#define YOUTUBE_SEARCH_KEY @"AIzaSyCUHFVmM7A3xA0Z2yWrojDEr71m6NGb0Y8"
@interface YoutubeHelper : NSObject

+ (void)getYoutubeListVideo:(void (^)(NSMutableArray *videoList))success failure:(void (^)(NSError *error))failure;
@end
