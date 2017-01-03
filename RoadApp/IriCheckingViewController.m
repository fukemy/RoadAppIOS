//
//  IriCheckingViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "IriCheckingViewController.h"
#import "Constant.h"

@interface IriCheckingViewController ()

@end

@implementation IriCheckingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[MENU_ICI_CHECKING uppercaseString]];
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
