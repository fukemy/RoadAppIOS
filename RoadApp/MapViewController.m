//
//  MapViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "MapViewController.h"
#import "Constant.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[MENU_MAP uppercaseString]];
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
