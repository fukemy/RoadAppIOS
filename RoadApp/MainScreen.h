//
//  MainScreen.h
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDViewPager.h"

@interface MainScreen : UIViewController<KDViewPagerDatasource, KDViewPagerDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UIView *viewpager;
@property (nonatomic, strong) KDViewPager *pager;
@property (nonatomic, assign) NSUInteger count;

@end
