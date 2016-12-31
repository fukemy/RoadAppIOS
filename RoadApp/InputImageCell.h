//
//  InputImageCell.h
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputImageDelegare <NSObject>
-(void) addMoreImage;
-(void) onLongPress:(UILongPressGestureRecognizer *)gr;
-(void) deleteImageAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface InputImageCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage;
- (IBAction)addImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *imgDelete;
@property (weak, nonatomic) NSIndexPath *indexPath;
- (IBAction)deleteImage:(id)sender;

@property (nonatomic,strong) id<InputImageDelegare> delegate;
- (void) loadImageFromAsset:(NSString *)path;
@end
