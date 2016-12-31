//
//  InputImageCell.m
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputImageCell.h"

@implementation InputImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)addImage:(id)sender {
    [_delegate addMoreImage];
}
@end
