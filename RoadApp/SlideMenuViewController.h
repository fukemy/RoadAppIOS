//
//  SideMenuViewController.h
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@end
