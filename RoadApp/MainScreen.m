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

@interface MainScreen ()

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupPager];
    [self reloadViewPager];
}

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

-(UIViewController *)kdViewPager:(KDViewPager *)viewPager controllerAtIndex:(NSUInteger)index cachedController:(UIViewController *)cachedController {
    if (cachedController == nil) {
        if(index == 0){
            cachedController = [[RoadTestPageController alloc] initWithData:nil];
        }else{
            cachedController = [[ReportPageController alloc] init];
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
