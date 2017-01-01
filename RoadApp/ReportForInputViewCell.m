//
//  ReportForInputViewCell.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ReportForInputViewCell.h"

@implementation ReportForInputViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)addImage:(id)sender {
    [_delegate addImageAt:_indexPath withView:_btAddImage];
}

- (IBAction)addMoreitem:(id)sender {
    [_delegate addMoreInput];
}
@end
