//
//  RoadTestPageController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "RoadTestPageController.h"
#import "RoadTestCell.h"
#import "Constant.h"
#import "Utilities.h"
#import "DataItemModel.h"
#import "TLYShyNavBarManager.h"
#import "InputViewController.h"
#import <CoreImage/CoreImage.h>

@interface RoadTestPageController (){
    int widthSize, heightSize;
    NSMutableArray *itemList;
}

@end

@implementation RoadTestPageController

- (void)viewDidLoad{
    [super viewDidLoad];
    widthSize = ([UIScreen mainScreen].bounds.size.width - 10 * 5 ) / 3;
    heightSize = ([UIScreen mainScreen].bounds.size.width - 10 * 5 ) / 3;
//    self.shyNavBarManager.scrollView = self.cvItem;
    [self initData];
}

- (void) initData{
    itemList = [Utilities getSectionListItem];
    [_cvItem reloadData];
}

- (void) changeDisplayItemMode{
    _isList = !_isList;
    widthSize = _isList ? [UIScreen mainScreen].bounds.size.width - 10 * 2  : ([UIScreen mainScreen].bounds.size.width - 10 * 5 ) / 3;
    [_cvItem reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RoadTestCell *cell = (RoadTestCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"RoadTestCell" forIndexPath:indexPath];
    DataItemModel* item = [[DataItemModel alloc] initWithDictionary:[itemList objectAtIndex:indexPath.row]];
    cell.layer.cornerRadius =  5.0f;
    cell.layer.masksToBounds = YES;
    cell.tfTitle.text = item.ItemName;
    cell.imgItem.image = [Utilities imageWithImage:[Utilities getItemBackground:(int)indexPath.row]
                                      scaledToSize:CGSizeMake(widthSize, heightSize)];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return itemList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(widthSize, heightSize);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{       
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    InputViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"InputViewController"];
    DataItemModel* item = [[DataItemModel alloc] initWithDictionary:[itemList objectAtIndex:indexPath.row]];
    vc.dataItemModel = item;
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
