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
#import "InputImageCell.h"
#import "ImageDb.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ReportInformationController (){
    NSMutableArray *imageList;
    BOOL isFullScreen;
    CGRect prevFrame;
}

@end

@implementation ReportInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:[THONG_TIN_CHI_TIET uppercaseString]];
    
    [self initLayout];
    [self initData];
}

- (void) initLayout{
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *backButon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self action:@selector(goBack)];
    self.navigationController.navigationItem.leftBarButtonItems = @[backButon];
    
    _btDone.layer.cornerRadius = _btDone.frame.size.width / 2;
    _btDone.layer.masksToBounds = YES;
    
    _viewTongQuan.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewTongQuan.alpha  = 0.3;
    _viewTongQuan.layer.cornerRadius = 10.0f;
    _viewChiTiest.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewChiTiest.alpha  = 0.3;
    _viewChiTiest.layer.cornerRadius = 10.0f;
    _viewImage.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewImage.alpha  = 0.2;
    _viewImage.layer.cornerRadius = 10.0f;
    
    _mapView.alpha  = 0.6;
    _mapView.layer.cornerRadius = 10.0f;
    
    [_cvImage setClipsToBounds:NO];
    [_cvImage registerNib:[UINib nibWithNibName:@"InputImageCell" bundle:nil] forCellWithReuseIdentifier:@"InputImageCell"];
}

- (void) initData{
    _lbDanhmuc.text = [NSString stringWithFormat:@"Tên đường: %@", _itemModel.tenduong];
    _lbLyTrinh.text = [NSString stringWithFormat:@"Lý trình: %@", _itemModel.lytrinh];
    _lbTime.text = [NSString stringWithFormat:@"Thời gian: %@", [Utilities dateStringFromTimeStamp:_itemModel.thoigiannhap]];
    _lbViTri.text = [NSString stringWithFormat:@"Vị trí: %@ - %@", _itemModel.kinhdo, _itemModel.vido];
    _lbStatus.text = @"Chưa cập nhập.";
    
    _lbHangMuc.text = [NSString stringWithFormat:@"Danh mục: %@", _itemModel.datatypename];
    _lbTinhTrang.text = [NSString stringWithFormat:@"Tình trang: %@", _itemModel.danhgia];
    _lbMoTaChiTiet.text = [NSString stringWithFormat:@"Mô tả chi tiết: %@", _itemModel.motatinhtrang];
    
    if(!_itemModel.kinhdo && !_itemModel.vido){
//        _mapView.camera = [GMSCameraPosition cameraWithLatitude:_itemModel.kinhdo longitude:_itemModel.vido zoom:14];
    }
    
    isFullScreen = false;
    imageList = [ImageDb findImageWithUUID:_itemModel.dataid];
    NSLog(@"ImageList: %@", imageList);
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imageList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width / 3 - 20, self.view.frame.size.width / 3 - 20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InputImageCell" forIndexPath:indexPath];
    [cell setClipsToBounds:NO];
    ImageDb *img = [imageList objectAtIndex:indexPath.row];
    
    NSURL* aURL = [NSURL URLWithString:img.imagename];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:aURL resultBlock:^(ALAsset *asset)
     {
         UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
         
         cell.img.image = copyOfOriginalImage;
     }
            failureBlock:^(NSError *error)
     {
         // error handling
         NSLog(@"failure-----: %@", [error localizedDescription]);
     }];
    
    [cell.btnAddImage setHidden:YES];
    [cell.imgDelete setHidden:YES];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = (InputImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self imgToFullScreen:cell.img];
}

- (void)imageTouched:(UITapGestureRecognizer *) sender{
    
}

-(void)imgToFullScreen:(UIImageView *) image{
    image.contentMode = UIViewContentModeScaleAspectFit;
    if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = image.frame;
            [image setUserInteractionEnabled:NO];
            [image setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }completion:^(BOOL finished){
            isFullScreen = true;
            [image setUserInteractionEnabled:YES];
        }];
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [image setFrame:prevFrame];
            [image setUserInteractionEnabled:NO];
        }completion:^(BOOL finished){
            [image setUserInteractionEnabled:YES];
            isFullScreen = false;
        }];
        return;
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
