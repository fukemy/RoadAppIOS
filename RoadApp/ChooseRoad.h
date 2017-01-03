//
//  ChooseRoad.h
//  RoadApp
//
//  Created by devil2010 on 1/2/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"

@protocol ChooseRoadDelegate <NSObject>
- (void) choosenRoadIndex:(NSDictionary *) dict;
@end
@interface ChooseRoad : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *cvRoad;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) WYPopoverController *popOver;

@property (nonatomic,strong) id<ChooseRoadDelegate> delegate;
@end
