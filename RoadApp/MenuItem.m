//
//  MenuItem.m
//  RoadApp
//
//  Created by admin2 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "MenuItem.h"
#import "Utilities.h"

@implementation MenuItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[Utilities colorwithHexString:@"FFFFFF" alpha:0.05f]];
    [self setSelectedBackgroundView:selectedBackgroundView];
}
@end
