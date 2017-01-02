//
//  ReportScreenViewController.m
//  RoadApp
//
//  Created by admin2 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ReportScreenViewController.h"
#import "SlideMenuViewController.h"
#import "SlideNavigationController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "Utilities.h"
#import "DataTypeItemDb.h"

@interface ReportScreenViewController (){
    NSMutableArray *dataList;
}

@end

@implementation ReportScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:MENU_REPORT];
    [self initLayout];
    [self initData];
}

- (void) initLayout{
    [_cvData registerNib:[UINib nibWithNibName:@"ReportScreenViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReportScreenViewCell"];
}

- (void) initData{
    dataList = [DataTypeItemDb getAllDataTypeItem];
    [_cvData reloadData];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportScreenViewCell *cell = (ReportScreenViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportScreenViewCell" forIndexPath:indexPath];
    
    cell.topViewOverlay.backgroundColor = [Utilities colorFromHexString:LIGHT_GRAY_COLOR];
    cell.topview.backgroundColor = [Utilities colorFromHexString:LIGHT_GRAY_COLOR];
    cell.topview.layer.cornerRadius = 10.0f;
    cell.btmViewOverlay.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    cell.btmView.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    cell.btmView.layer.cornerRadius = 10.0f;

    DataTypeItemDb *data = [dataList objectAtIndex:indexPath.row];
    cell.lbTime.text = data.thoigiannhap ? data.thoigiannhap : @"";
    cell.lbDataTypeName.text = data.datatypename ? data.datatypename : @"";
    cell.lbRoadName.text = data.tenduong ? data.tenduong : @"";
    cell.lbCategory.text = data.danhgia ? data.danhgia : @"";
    
    
    return cell;
}

@end
