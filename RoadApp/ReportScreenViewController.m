//
//  ReportScreenViewController.m
//  RoadApp
//
//  Created by admin2 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ReportScreenViewController.h"
#import "SlideMenuViewController.h"
#import "SlideNavigationController.h"
#import "AppDelegate.h"
#import "Constant.h"

@interface ReportScreenViewController ()

@end

@implementation ReportScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:MENU_REPORT];
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
