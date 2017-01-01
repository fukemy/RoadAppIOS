//
//  InputImageForCell.h
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputImageCell.h"

@protocol InputImageForCellDelegare <NSObject>
-(void) doneAddImage:(NSMutableArray *) dataListArr withUUID:(NSString *)UUID;
@end

@interface InputImageForCell : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, InputImageDelegare, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cvImg;
@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSString *UUID;
@property (weak, nonatomic) IBOutlet UIButton *btBack;
- (void) initImagePanelWithData:(NSMutableArray *)dataList;
- (IBAction)dismissView:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tfIntro;
@property (weak, nonatomic) IBOutlet UILabel *tfConcept;
@property (nonatomic,strong) id<InputImageForCellDelegare> delegate;
@end
