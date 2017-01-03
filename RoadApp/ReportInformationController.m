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

@interface ReportInformationController (){
    NSMutableArray *imageList;
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
    
    _mapView.alpha  = 0.6;
    _mapView.layer.cornerRadius = 10.0f;
    
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
    
    imageList = [[NSMutableArray alloc] init];
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imageList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, self.view.frame.size.width - 20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InputImageCell" forIndexPath:indexPath];
    
    
    [cell.btnAddImage setHidden:YES];
    [cell.imgDelete setHidden:YES];
    return cell;
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
