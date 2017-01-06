//
//  ReportScreenViewController.h
//  RoadApp
//
//  Created by admin2 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ReportScreenViewCell.h"
#import "VCFloatingActionButton.h"

@interface ReportDiary : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, ReportScreenViewCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cvData;
- (IBAction)showSetting:(id)sender;

@end
