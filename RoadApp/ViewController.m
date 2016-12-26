//
//  ViewController.m
//  RoadApp
//
//  Created by admin2 on 11/7/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ViewController.h"
#import "LoginController.h"
#import "SVProgressHUD.h"
#import "JSONParser.h"
#import "Constant.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [NSThread sleepForTimeInterval:1.0f];
    [_loading setHidden:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [loginVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
