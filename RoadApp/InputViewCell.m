//
//  InputViewCell.m
//  RoadApp
//
//  Created by devil2010 on 12/29/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputViewCell.h"

@implementation InputViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addMoreInput:(id)sender {
    [_delegate addMoreInput];
}
- (IBAction)addImage:(id)sender {
    [_delegate addImage:_indexPath];
}
@end
