//
//  InputViewCell.h
//  RoadApp
//
//  Created by devil2010 on 12/29/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InputCellDelegare <NSObject>
-(void) addMoreInput;
-(void) addImage:(NSIndexPath *)indexPath;
@end
@interface InputViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *pkRequiredItem;
@property (weak, nonatomic) IBOutlet UITextField *pkStatusItem;
@property (weak, nonatomic) IBOutlet UIView *rootVIew;
@property (weak, nonatomic) NSIndexPath *indexPath;

- (IBAction)addMoreInput:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIView *viewImage;

@property (nonatomic,strong) id<InputCellDelegare> delegate;
- (IBAction)addImage:(id)sender;

@end
