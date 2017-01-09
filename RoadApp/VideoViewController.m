//
//  VideoViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "VideoViewController.h"
#import "Constant.h"
#import "SVProgressHUD.h"
#import "Utilities.h"
#import "YoutubeHelper.h"

@implementation VideoViewController{
    NSMutableArray *videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[MENU_VIDEO uppercaseString]];
    
    [SVProgressHUD showWithStatus:GETTING_YOUTUBE_VIDEO maskType:SVProgressHUDMaskTypeBlack];
    [YoutubeHelper getYoutubeListVideo:^(NSMutableArray *videoList) {
        [SVProgressHUD dismiss];
        videos = videoList;
    } failure:^(NSError *error) {
        NSLog(@"error get youtube: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
        videos = [[NSMutableArray alloc] init];
    }];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}



@end
