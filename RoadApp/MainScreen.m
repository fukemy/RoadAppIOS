//
//  MainScreen.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "MainScreen.h"
#import "RoadTestPageController.h"
#import "ReportPageController.h"
#import "MFSideMenu.h"
#import "SlideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"
#import "RoadTestPageController.h"
#import "ReportPageController.h"
#import "Constant.h"
#import "Utilities.h"

@interface MainScreen (){
    RoadTestPageController *roadTestVC;
}

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = MAIN_SCREEN_VN;
    
    [self configToolbar];
    
    [self setupPager];
    
    [self reloadViewPager];
}

- (void) configToolbar{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [Utilities colorFromHexString:MAIN_COLOR];
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.hidesBarsOnSwipe = NO;
}

- (IBAction)segChange:(id)sender {
    [_pager setCurrentPage:_segment.selectedSegmentIndex animated:YES];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (void)setupMenuBarButtonItems {
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItems = nil;
    } else {;
        self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem];
    }
}

- (void)leftSideMenuButtonPressed:(id)sender{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (IBAction)rightBarClick:(id)sender {
    [roadTestVC changeDisplayItemMode];
}


/*
 * init view pager
 */
- (void) setupPager{
    _count = 0;
    _pager = [[KDViewPager alloc] initWithController:self inView:_viewpager];
    _pager.datasource = self;
    _pager.delegate = self;
}

- (void) reloadViewPager{
    _count = 2;
    [_pager reload];
    [_pager setCurrentPage:0];
}

- (RoadTestPageController*) getRoadTestPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    roadTestVC = [storyboard instantiateViewControllerWithIdentifier:@"RoadTestPageController"];
    return roadTestVC;
}

- (ReportPageController*) getReportPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReportPageController *reportVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportPageController"];
    return reportVC;
}

-(UIViewController *)kdViewPager:(KDViewPager *)viewPager controllerAtIndex:(NSUInteger)index cachedController:(UIViewController *)cachedController {
    if (cachedController == nil) {
        if(index == 0){
            cachedController = [self getRoadTestPage];
        }else{
            cachedController = [self getReportPage];
        }
    }
    return cachedController;
}

-(NSUInteger)numberOfPages:(KDViewPager *)viewPager {
    return _count;
}

#pragma mark - delegate
-(void)kdViewpager:(KDViewPager *)viewPager didSelectPage:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction{
    if(index == 0){
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        [self.navigationItem.rightBarButtonItem setTintColor:nil];
    }else{
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor clearColor]];
    }
}

-(void)kdViewpager:(KDViewPager *)viewPager willSelectPage:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction{
}

@end
