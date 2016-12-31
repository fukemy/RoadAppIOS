//
//  InputImageForCell.h
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputImageCell.h"

@interface InputImageForCell : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, InputImageDelegare, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *cvImg;
@property (nonatomic) NSMutableArray *data;
- (void) initImagePanelWithData:(NSMutableArray *)dataList;
- (IBAction)dismissView:(id)sender;
@end