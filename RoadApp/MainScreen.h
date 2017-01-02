//
//  MainScreen.h
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDViewPager.h"
#import "SlideNavigationController.h"

@interface MainScreen : UIViewController<KDViewPagerDatasource, KDViewPagerDelegate, SlideNavigationControllerDelegate, UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewpager;
@property (nonatomic, strong) KDViewPager *pager;
@property (nonatomic, assign) NSUInteger count;
@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btChooseRoadName;
- (IBAction)chooseRoad:(id)sender;

- (void) switchToFirstPage;

@end
