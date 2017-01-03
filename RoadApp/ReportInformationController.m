//
//  ReportInformationController.m
//  RoadApp
//
//  Created by devil2010 on 1/2/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ReportInformationController.h"
#import "Utilities.h"
#import "Constant.h"

@interface ReportInformationController ()

@end

@implementation ReportInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

- (void) initLayout{
    _viewTongQuan.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewTongQuan.layer.cornerRadius = 10.0f;
    _viewChiTiest.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewChiTiest.layer.cornerRadius = 10.0f;
}

@end
