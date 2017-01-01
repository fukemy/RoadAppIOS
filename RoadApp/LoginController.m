//
//  LoginController.m
//  RoadProject
//
//  Created by admin2 on 11/7/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "LoginController.h"
#import "JSONParser.h"
#import "SVProgressHUD.h"
#import "Constant.h"
#import "MainScreen.h"
#import "RoadInformationModel.h"
#import "Utilities.h"
#import "DataItemModel.h"

@interface LoginController (){
    NSString* token;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

-(void) dismissKeyboard{
    //[self dismissViewControllerAnimated:self completion:nil];
    [self.view endEditing:YES];
}

#pragma mark - keyboardDelegate
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
        if (self.view.frame.origin.y >= 0) {
    
            [UIView animateWithDuration:0.5 animations:^{
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if (self.view.frame.origin.y < 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 100, self.view.frame.size.width, self.view.frame.size.height);
        }];
        
    }
}

- (IBAction)login:(id)sender {
    [self.view endEditing:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL, GET_TOKEN_URL];
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    [JSONParser getJsonParser:url withParameters:nil success:^(id responseObject) {
        NSLog(@"login response: %@", responseObject);
        
        token = [[NSString stringWithFormat:@"%@",responseObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
        [self getAllRoadInfo];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
}

- (void) getAllRoadInfo{
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",BASE_URL, GET_ALL_ROAD_URL, token];
    [JSONParser getJsonParser:url withParameters:nil success:^(id responseObject) {
        NSString *dataJson = (NSString *)responseObject;
        dataJson = [dataJson stringByReplacingOccurrencesOfString:@"[" withString:@""];
        dataJson = [dataJson stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        [[NSUserDefaults standardUserDefaults] setObject:dataJson forKey:ROAD_DATA];
        [self getAllItem];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
}

- (void) getAllItem{
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",BASE_URL, GET_ALL_ITEM_URL, token];
    [JSONParser getJsonParser:url withParameters:nil success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        NSString *dataJson = [[NSString alloc] initWithFormat:@"%@", responseObject];
        
        [[NSUserDefaults standardUserDefaults] setObject:dataJson forKey:ITEM_DATA_LIST];
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:USER_LOGGED];
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:^{
            [_delegate loginSuccess];
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
}

@end
