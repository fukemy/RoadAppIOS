//
//  ReportScreenViewCell.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ReportScreenViewCell.h"

@implementation ReportScreenViewCell

- (void)awakeFromNib {
    // Initialization code
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnView)]];
}

- (void)clickOnView{
    [_delegate didSelectItem:_indexPath];
}
@end
