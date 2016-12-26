//
//  RoadTestPageController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "RoadTestPageController.h"
#import "RoadTestCell.h"

@interface RoadTestPageController ()

@end

@implementation RoadTestPageController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RoadTestCell *cell = (RoadTestCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"RoadTestCell" forIndexPath:indexPath];
    cell.layer.cornerRadius =  5.0f;
    cell.layer.masksToBounds = YES;
    
    cell.tfTitle.text = @"test";
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 18;
}


@end
