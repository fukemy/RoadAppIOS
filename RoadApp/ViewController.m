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
#import "MainScreen.h"
#import "RoadTestPageController.h"
#import "ReportPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                       int isLogged = [[[NSUserDefaults standardUserDefaults] valueForKey:USER_LOGGED] intValue];
                       if(isLogged && isLogged == 1){
                           [self goToMainScreen];
                       }else{
                           [self showLogin];
                       }
                   });
}

-(void)loginSuccess{
    [self goToMainScreen];
}

- (void) showLogin{
    NSLog(@"showLogin");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [loginVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    loginVC.delegate = self;
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}

- (void) goToMainScreen{
    NSLog(@"goToMainScreen");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainScreen *mainScreenVC = [storyboard instantiateViewControllerWithIdentifier:@"MainScreen"];
    [self.navigationController pushViewController:mainScreenVC animated:YES];
}


@end
