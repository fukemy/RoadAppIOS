//
//  LoginController.m
//  RoadProject
//
//  Created by admin2 on 11/7/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "LoginController.h"
#import "Frameworks/JSON/JSONParser.h"
#import "Frameworks/SVProgressHUD/SVProgressHUD.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBg)];
    tapBackground.numberOfTapsRequired = 1;
    [_loginControllerBg addGestureRecognizer:tapBackground];
    
    _loginViewInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loginViewInput.layer.borderWidth = 1.0;
    _loginViewInput.layer.cornerRadius = 5.0;
    _loginViewInput.layer.masksToBounds = true;
    
}

-(void) dismissBg{
    [self dismissViewControllerAnimated:self completion:nil];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)login:(id)sender {
    NSString *url = @"http://khaosatdiachat.com:8887/api/users/login/dungdv/123456";
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    [JSONParser getJsonParser:url withParameters:nil success:^(id responseObject) {
         NSLog(@"response: %@", responseObject);
        @try{
            int a = [@"f" intValue];
        }@catch(NSException *e){
            NSLog(@"catch exception: %@", e);
        }@finally{
            NSLog(@"finally");
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
}

@end
