//
//  ReportPageController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ReportPageController.h"

@interface ReportPageController ()

@end

@implementation ReportPageController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReportPageController" owner:self options:nil];
        UIView *view = (UIView *)[nib objectAtIndex:0];
        view.frame = self.view.bounds;
        view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
