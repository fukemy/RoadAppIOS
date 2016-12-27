//
//  ViewController.h
//  RoadApp
//
//  Created by admin2 on 11/7/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"

@interface ViewController : UIViewController <LoginDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end

