//
//  LoginController.h
//  RoadProject
//
//  Created by admin2 on 11/7/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate <NSObject>
-(void) loginSuccess;
@end

@interface LoginController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *loginControllerBg;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UITextField *tfUsername;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (strong, nonatomic) IBOutlet UIView *loginViewInput;
@property (nonatomic,strong) id<LoginDelegate> delegate;
- (IBAction)login:(id)sender;

@end
