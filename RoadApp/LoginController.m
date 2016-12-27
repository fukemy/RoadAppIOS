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
    
    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBg)];
    tapBackground.numberOfTapsRequired = 1;
    [_loginControllerBg addGestureRecognizer:tapBackground];
    
    _loginViewInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loginViewInput.layer.borderWidth = 1.0;
    _loginViewInput.layer.cornerRadius = 5.0;
    _loginViewInput.layer.masksToBounds = true;
    
}

-(void) dismissBg{
    //[self dismissViewControllerAnimated:self completion:nil];
    //[self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)login:(id)sender {
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
//        dataJson = [dataJson stringByReplacingOccurrencesOfString:@":" withString:@"-"];
        dataJson = [dataJson stringByReplacingOccurrencesOfString:@"[" withString:@""];
        dataJson = [dataJson stringByReplacingOccurrencesOfString:@"]" withString:@""];
//        NSLog(@"getAllRoadInfo: %@", dataJson);
        
        RoadInformationModel *road = [[RoadInformationModel alloc] initWithJSONString:dataJson];
        [[NSUserDefaults standardUserDefaults] setObject:dataJson forKey:ROAD_DATA];
//        NSLog(@"road data: %@", road);
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
//        NSLog(@"getAllItem: %@", dataJson);
        
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
