//
//  ReportController.m
//  RoadApp
//
//  Created by devil2010 on 1/5/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ReportController.h"
#import "ReportDiary.h"
#import "ReportStatus.h"
#import "Utilities.h"
#import "Constant.h"
#import "UIView+MaterialDesign.h"

@implementation ReportController{
    ReportDiary *diaryVC;
    ReportStatus *statusVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTitle:[MENU_REPORT uppercaseString]];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    diaryVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportDiary"];
    statusVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportStatus"];
    
    [self.view addSubview:diaryVC.view];
    [self.view addSubview:statusVC.view];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (void)showDetailsAction:(UIButton *)sender event:(UIEvent *)event {
    CGPoint exactTouchPosition = [[[event allTouches] anyObject] locationInView:diaryVC.view];
    [UIView mdInflateTransitionFromView:diaryVC.view toView:statusVC.view originalPoint:exactTouchPosition duration:0.7 completion:nil];
}

- (void)backAction:(UIButton *)sender event:(UIEvent *)event {
    CGPoint exactTouchPosition = [[[event allTouches] anyObject] locationInView:statusVC.view];
    // [UIView mdDeflateTransitionFromView:self.viewTwo toView:self.viewOne originalPoint:exactTouchPosition duration:0.4 completion:nil];
    [UIView mdInflateTransitionFromView:statusVC.view toView:diaryVC.view originalPoint:exactTouchPosition duration:0.7 completion:^{
        NSLog(@"completed!");
    }];
}

@end
