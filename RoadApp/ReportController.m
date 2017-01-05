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

@interface ReportController ()

@end

@implementation ReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTitle:[MENU_REPORT uppercaseString]];
    
    [self configToolbar];
    [self setupPager];
    
    [self reloadViewPager];
}


- (void) configToolbar{
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [_pager setCurrentPage:item.tag animated:YES];
}

#pragma mark - view pager
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

- (ReportDiary*) getReportDiaryPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"ReportDiary"];
}

- (ReportStatus*) getReportStatusPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"ReportStatus"];
}

-(UIViewController *)kdViewPager:(KDViewPager *)viewPager controllerAtIndex:(NSUInteger)index cachedController:(UIViewController *)cachedController {
    if (cachedController == nil) {
        if(index == 0){
            cachedController = [self getReportDiaryPage];
        }else{
            cachedController = [self getReportStatusPage];
        }
    }
    return cachedController;
}

-(NSUInteger)numberOfPages:(KDViewPager *)viewPager {
    return _count;
}

#pragma mark - slide navigation
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
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
