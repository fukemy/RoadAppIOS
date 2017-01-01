//
//  ReportScreenViewCell.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportScreenViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbRoadName;
@property (weak, nonatomic) IBOutlet UILabel *lbCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbDataTypeName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIView *viewBtm;
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UILabel *btmTopView;

@end
