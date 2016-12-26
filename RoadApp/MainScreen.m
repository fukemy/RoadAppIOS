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
#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"
#import "RoadTestPageController.h"
#import "ReportPageController.h"

@interface MainScreen ()

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"test";
    
    [self setupSlideMenu];
    [self setupMenuBarButtonItems];
    
    [self setupPager];
    [self reloadViewPager];
}


- (IBAction)segChange:(id)sender {
    [_pager setCurrentPage:_segment.selectedSegmentIndex animated:YES];
}



/*
 * init slide menu
 */
-(void) setupSlideMenu{
    UIWindow *window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];
    
    SideMenuViewController *leftMenuViewController = [[SideMenuViewController alloc] init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:self.navigationController
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:nil];
    window.rootViewController = container;
    [window makeKeyAndVisible];
}

- (void)setupMenuBarButtonItems {
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStylePlain
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
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
    RoadTestPageController *roadTestVC = [storyboard instantiateViewControllerWithIdentifier:@"RoadTestPageController"];
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
}

-(void)kdViewpager:(KDViewPager *)viewPager willSelectPage:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction{
}

@end
