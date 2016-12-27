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

@interface ReportScreenViewController ()

@end

@implementation ReportScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSlideMenu];
}

-(void) setupSlideMenu{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    SlideMenuViewController *leftMenu = (SlideMenuViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"SlideMenuViewController"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    ((SlideMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled = YES;
}

@end
