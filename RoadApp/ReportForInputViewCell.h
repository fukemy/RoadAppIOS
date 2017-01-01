//
//  ReportForInputViewCell.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReportForInputViewCellDelegare <NSObject>
-(void) addMoreInput;
-(void) addImageAt:(NSIndexPath *)indexPath withView:(UIView *) view;
-(void) getLocation;
@end

@interface ReportForInputViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextField *pkReportType;
@property (weak, nonatomic) IBOutlet UITextField *tfLyTrinh;
@property (weak, nonatomic) IBOutlet UITextView *tvContent;
@property (weak, nonatomic) IBOutlet UITextField *tfPlaceholder;
@property (weak, nonatomic) IBOutlet UIButton *btAddImage;
- (IBAction)addImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btAddMoreItem;
- (IBAction)addMoreitem:(id)sender;
@property (nonatomic,strong) id<ReportForInputViewCellDelegare> delegate;
@property (weak, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *tfNumOfImage;
@property (weak, nonatomic) IBOutlet UILabel *tfNumOfVideo;
- (IBAction)setLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgLocationStatus;

@end
