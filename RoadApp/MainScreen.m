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
#import "SlideMenuViewController.h"
#import "AppDelegate.h"
#import "RoadTestPageController.h"
#import "ReportPageController.h"
#import "Constant.h"
#import "Utilities.h"
#import "WYPopoverController.h"
#import "ChooseRoad.h"

@interface MainScreen (){
    RoadTestPageController *roadTestVC;
    WYPopoverController* popoverController;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    SlideNavigationController *bar = (SlideNavigationController *)self.navigationController;
    bar.navigationBarHidden = NO;
}

- (void) configToolbar{
    //    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.tabbar.selectedItem = [[self.tabbar items] objectAtIndex:0];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [_pager setCurrentPage:item.tag animated:YES];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}
- (IBAction)chooseRoad:(id)sender {
    
    NSString *itemDataString = [[NSUserDefaults standardUserDefaults] objectForKey:ROAD_DATA];
    
    NSError *error = nil;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    
    NSData *JSONData = [itemDataString dataUsingEncoding:NSUTF8StringEncoding];
    [dataList addObject:@"CHOOSE ROAD NAME"];
    if(JSONData == nil){
        dataList = [[NSMutableArray alloc] init];
    }else{
        NSMutableArray * temp = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        for(NSMutableDictionary *dict in temp){
            [dataList addObject:dict];
        }
    }
    
    if(dataList.count == 0)
        return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChooseRoad *chooseRoadVC = [storyboard instantiateViewControllerWithIdentifier:@"ChooseRoad"];
    chooseRoadVC.dataList = dataList;
    chooseRoadVC.delegate = self;
    UINavigationController *destVC = [[UINavigationController alloc] initWithRootViewController:chooseRoadVC];
    
    [destVC setPreferredContentSize:CGSizeMake(250, dataList.count * 50)];
    [destVC setModalPresentationStyle:UIModalPresentationPopover];
    
    
    UIView *view = [sender valueForKey:@"view"];
    
    destVC.popoverPresentationController.delegate = self;
    destVC.popoverPresentationController.barButtonItem = (UIBarButtonItem *)sender;
    destVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    destVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    [destVC setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:destVC animated:YES completion:nil];
    
//    popoverController = [[WYPopoverController alloc] initWithContentViewController:destVC];
//    [popoverController presentPopoverFromRect:[view bounds]
//                             inView:view
//           permittedArrowDirections:WYPopoverArrowDirectionAny
//                           animated:YES
//                            options:WYPopoverAnimationOptionFadeWithScale];
}

-(void)choosenRoadIndex:(NSDictionary *) dict{
}

- (void) switchToFirstPage{
    [_pager setCurrentPage:0 animated:YES];
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
    
    self.tabbar.selectedItem = [[self.tabbar items] objectAtIndex:index];
}

-(void)kdViewpager:(KDViewPager *)viewPager willSelectPage:(NSUInteger)index direction:(UIPageViewControllerNavigationDirection)direction{
}

@end
