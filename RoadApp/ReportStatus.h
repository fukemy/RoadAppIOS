//
//  ViewController.h
//  matyExpandableTableView
//
//  Created by Maitrayee Ghosh on 05/08/14.
//  Copyright (c) 2014 Maitrayee Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportStatus : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray  *arrayForBool;
    NSMutableArray *sectionTitleArray;

}
@property (weak, nonatomic) IBOutlet UITableView *expandableTableView;

@end
