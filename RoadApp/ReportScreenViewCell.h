//
//  ReportScreenViewCell.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReportScreenViewCellDelegate <NSObject>

- (void) didSelectItem:(NSIndexPath *)indexPath;

@end

@interface ReportScreenViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbRoadName;
@property (weak, nonatomic) IBOutlet UILabel *lbCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbDataTypeName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIView *topViewOverlay;
@property (weak, nonatomic) IBOutlet UIView *btmView;
@property (weak, nonatomic) IBOutlet UIView *btmViewOverlay;
@property (nonatomic,strong) id<ReportScreenViewCellDelegate> delegate;
@property (weak, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *dataItemname;

@end
