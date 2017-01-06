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
    VCFloatingActionButton *vcButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[MENU_REPORT uppercaseString]];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    diaryVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportDiary"];
    statusVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportStatus"];
    
    [self displayContentController:statusVC];
    [self displayContentController:diaryVC];
    
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 20,
                                   [UIScreen mainScreen].bounds.size.height - 44 - 20, 44, 44);
    vcButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"plus"] withScrollview:nil];
    vcButton.imageArray = @[@"upload", @"status_report_icon"];
    vcButton.labelArray = @[@"Upload", @"Show by collection"];
    vcButton.hideWhileScrolling = NO;
    vcButton.delegate = self;
    vcButton.isShow = 1;
    [self.view addSubview:vcButton];
    vcButton.layer.zPosition = MAXFLOAT;
}

-(void) didSelectMenuOptionAtIndex:(NSInteger)row point:(CGPoint)point
{
    NSLog(@"Floating action tapped index %tu",row);
    switch (row) {
        case 0:
//            [self uploadData];
            break;
        case 1:{
            if(vcButton.isShow == 1)
                [self showStatusPage:point.x and:point.y];
            else
                [self showDiaryPage:point.x and:point.y];
        }
            break;
            
        default:
            break;
    }
}

- (void) displayContentController: (UIViewController*) content;
{
    [self addChildViewController:content];
    content.view.bounds = self.view.bounds;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

- (void)showStatusPage:(CGFloat)x and:(CGFloat)y {
    [UIView mdInflateTransitionFromView:diaryVC.view toView:statusVC.view originalPoint:CGPointMake(x, y) duration:0.7 completion:^{
        [self.view bringSubviewToFront:vcButton];
        vcButton.imageArray = @[@"upload", @"diary_report_icon"];
        vcButton.labelArray = @[@"Upload", @"Show by diary"];
        vcButton.isShow = 0;
        [vcButton reloadInput];
    }];
}

- (void)showDiaryPage:(CGFloat)x and:(CGFloat)y {
    [UIView mdInflateTransitionFromView:statusVC.view toView:diaryVC.view originalPoint:CGPointMake(x, y) duration:0.7 completion:^{
        [self.view bringSubviewToFront:vcButton];
        vcButton.imageArray = @[@"upload", @"status_report_icon"];
        vcButton.labelArray = @[@"Upload", @"by by diary"];
        vcButton.isShow = 1;
        [vcButton reloadInput];

    }];
}

@end
