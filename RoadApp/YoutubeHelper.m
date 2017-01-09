//
//  YoutubeHelper.m
//  RoadApp
//
//  Created by devil2010 on 1/9/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "YoutubeHelper.h"
#import "Utilities.h"
#import "Constant.h"

@implementation YoutubeHelper

+(void)getYoutubeListVideo:(void (^)(NSMutableArray *videoList))success failure:(void (^)(NSError *error))failure{
    NSString * urlYouCanUseAsSample = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?key=%@&channelId=%@&part=snippet,id&order=date&maxResults=20", YOUTUBE_SEARCH_KEY, YOUTUBE_CHANNEL_ID];
    NSURL *url = [[NSURL alloc] initWithString: urlYouCanUseAsSample];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data && !connectionError) {
            NSError *jsonError;
            
            NSMutableArray *dataList = [[NSMutableArray alloc] init];
            NSMutableDictionary *videoDict;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            if (!jsonError) {
                NSLog(@"%@",jsonResult);
                id keyValuePairDict = jsonResult;
                NSMutableArray * itemList = keyValuePairDict[@"items"];
                for (int i = 0; i < itemList.count; i++) {
                    videoDict = [[NSMutableDictionary alloc] init];
                    id v_id0 = itemList[i];
                    NSDictionary * vid_id = v_id0[@"id"];
                    id v_id = vid_id;
                    NSString * video_ID = v_id[@"videoId"];
                    id snippet = itemList[i];
                    NSDictionary * snip = snippet[@"snippet"];
                    
                    id title = snip;
                    NSString * title_For_Video = title[@"title"];
                    NSString * desc_For_Video = title[@"description"];
                    NSString *channelTitle = title[@"channelTitle"];
                    
                    id tnail = snip;
                    NSDictionary * thumbnail_ = tnail[@"thumbnails"];
                    
                    id highRes = thumbnail_;
                    NSDictionary * high_res = highRes[@"high"];

                    id url_for_tnail = high_res;
                    NSString * thumbnail_url = url_for_tnail[@"url"];
                    @try{
                        [videoDict setObject:video_ID forKey:YOUTUBE_VIDEO_ID];
                        [videoDict setObject:title_For_Video forKey:YOUTUBE_VIDEO_VIDEO_TITLE];
                        [videoDict setObject:channelTitle forKey:YOUTUBE_VIDEO_CHANNEL_TITLE];
                        [videoDict setObject:desc_For_Video forKey:YOUTUBE_VIDEO_VIDEO_DESCRIPTION];
                        [videoDict setObject:thumbnail_url forKey:YOUTUBE_VIDEO_THUMBNAIL];
                        [dataList addObject:videoDict];
                    }@catch(NSException *ex){
                        NSLog(@" this video is upcomming with no data to present!");
                    }
                    
                }
                
                success(dataList);
                
            }
            else
            {
                failure(connectionError);
            }
        }
    }];

}
@end
