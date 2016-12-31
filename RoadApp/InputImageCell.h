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
@end

@interface InputImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnAddImage;
- (IBAction)addImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (nonatomic,strong) id<InputImageDelegare> delegate;
@end
