//
//  InputImageCell.m
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputImageCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation InputImageCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews{
    if(_indexPath != nil){
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        longPress.delegate = self;
        [self addGestureRecognizer:longPress];
    }
}
- (void)onLongPress:(UILongPressGestureRecognizer *)gr{
    if (gr.state == UIGestureRecognizerStateBegan) {
        [_delegate onLongPress:gr];
    }
}

- (void) loadImageFromAsset:(NSString *)path{
    NSURL* aURL = [NSURL URLWithString:path];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:aURL resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         
         self.img.image = copyOfOriginalImage;
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----");
     }];
}

- (IBAction)addImage:(id)sender {
    [_delegate addMoreImage];
}

- (IBAction)deleteImage:(id)sender {
    [_delegate deleteImageAtIndexPath:_indexPath];
}
@end
