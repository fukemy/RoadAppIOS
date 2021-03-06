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
#import <GoogleMaps/GoogleMaps.h>

@interface ReportInformationController (){
    NSMutableArray *imageList;
    BOOL isFullScreen, *isImageAnimating;
    UIImageView *preImg;
    CGRect preFrame;
    UIGestureRecognizer *gesture;
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
    self.navigationController.hidesBarsOnSwipe = NO;
    
    UIBarButtonItem *backButon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self action:@selector(goBack)];
    self.navigationController.navigationItem.leftBarButtonItems = @[backButon];
    
    _viewTongQuan.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewTongQuan.alpha  = 0.1;
    _viewTongQuan.layer.cornerRadius = 10.0f;
    _viewChiTiest.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewChiTiest.alpha  = 0.1;
    _viewChiTiest.layer.cornerRadius = 10.0f;
    _viewImage.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    _viewImage.alpha  = 0.1;
    _viewImage.layer.cornerRadius = 10.0f;
    
    _mapView.alpha  = 0.6;
    _mapView.layer.cornerRadius = 10.0f;
    
    [_cvImage setClipsToBounds:NO];
    [_cvImage registerNib:[UINib nibWithNibName:@"InputImageCell" bundle:nil] forCellWithReuseIdentifier:@"InputImageCell"];
    
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleZoom:)];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissZoom:)]];
    [_cvImage addGestureRecognizer:gesture];
    gesture.delegate = self;
    
    [_btDone setIsRaised:YES];
    [_btDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btDone setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_btDone addTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [_btDone setBackgroundColor:[Utilities colorFromHexString:MAIN_COLOR]];
    _btDone.tapCircleColor = [Utilities colorFromHexString:MAIN_COLOR];
    _btDone.cornerRadius = _btDone.frame.size.width / 2;
    _btDone.rippleFromTapLocation = NO;
    _btDone.rippleBeyondBounds = YES;
    _btDone.tapCircleDiameter = MAX(_btDone.frame.size.width, _btDone.frame.size.height) * 1.3;
    _btDone.delegate = self;
    
    NSArray *subviews = self.view.subviews;
    NSArray *viewHierarchy = [@[self.view] arrayByAddingObjectsFromArray:subviews];
    int i = 0;
    for (UIView *viewToCheck in viewHierarchy) {
        for (UIGestureRecognizer *gestureRecognizer in viewToCheck.gestureRecognizers) {
            gestureRecognizer.delaysTouchesBegan = NO;
        }
    }
    [_scrollView setDelaysContentTouches:NO];
    
}

-(void)didEndAnimationClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) initData{
    _lbDanhmuc.text = [NSString stringWithFormat:@"Tên đường: %@", _itemModel.tenduong];
    _lbLyTrinh.text = [NSString stringWithFormat:@"Lý trình: %@", _itemModel.lytrinh];
    _lbTime.text = [NSString stringWithFormat:@"Thời gian: %@", [Utilities dateStringFromTimeStamp:_itemModel.thoigiannhap]];
    _lbViTri.text = @"Vị trí: Đang cập nhập...";
    _lbStatus.text =  [_itemModel.isupload intValue] == 0 ? @"Trạng thái: chưa cập nhập." : @"Trạng thái: Đã upload lên server";
    
    _lbHangMuc.text = [NSString stringWithFormat:@"Danh mục: %@", _itemModel.datatypename];
    _lbTinhTrang.text = [NSString stringWithFormat:@"Tình trang: %@", _itemModel.danhgia];
    _lbMoTaChiTiet.text = [NSString stringWithFormat:@"Mô tả chi tiết: %@", _itemModel.motatinhtrang];
    [_lbMoTaChiTiet setLineBreakMode:NSLineBreakByClipping];
    
    if(_itemModel.kinhdo != 0 && _itemModel.vido != 0){
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[_itemModel.kinhdo doubleValue] longitude:[_itemModel.vido
                                                                                                          doubleValue]];
        GMSCameraPosition *newCameraPosition = [GMSCameraPosition cameraWithTarget:loc.coordinate zoom:16];
        [self.mapView animateToCameraPosition:newCameraPosition];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = loc.coordinate;
        marker.title = @"fap";
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
        marker.map = _mapView;
        
        [Utilities getLocationByCoor:loc success:^(id responseObject) {
            _lbViTri.text = responseObject;
            [Utilities sizeLabel:_lbViTri toRect:_lbViTri.frame];
        } failure:^(NSError *error) {
            NSLog(@"find location error: %@", error.debugDescription);
        }];
    }
    
    isFullScreen = NO;
    isImageAnimating = NO;
    imageList = [ImageDb findImageWithUUID:_itemModel.dataid];
    if(imageList.count > 0){
        [_lbImage setHidden:YES];
    }else{
        [_lbImage setHidden:NO];
    }
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
    return CGSizeMake(_cvImage.frame.size.width / 3 - 20, _cvImage.frame.size.width / 3 - 20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InputImageCell" forIndexPath:indexPath];
    [cell setClipsToBounds:NO];
    
    ImageDb *img = [imageList objectAtIndex:indexPath.row];
    [Utilities getPhotoByPath:img.imagename success:^(UIImage *image) {
        cell.img.image = image;
        
    } failure:^(NSError *error) {
        NSLog(@"failure-----: %@", [error localizedDescription]);
        cell.img.image = nil;
    }];
    
    [cell.btnAddImage setHidden:YES];
    [cell.imgDelete setHidden:YES];
    return cell;
}


-(void)imgToFullScreen:(UIImageView *) image withRect:(CGRect ) rect{
    int dx = -rect.origin.x;
    int dy = -rect.origin.y;
    if(isImageAnimating)
        return;
    if(!isFullScreen){
        isFullScreen = YES;
        preFrame = image.frame;
        preImg = image;
        isImageAnimating = YES;
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            preImg.frame = CGRectMake(dx, dy, self.view.frame.size.width, self.view.frame.size.height);
        }completion:^(BOOL finished){
            [_scrollView setScrollEnabled:NO];
            [_cvImage setScrollEnabled:NO];
            isImageAnimating = NO;
        }];
    }else{
        [preImg setUserInteractionEnabled:NO];
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            preImg.frame = preFrame;
            isImageAnimating = YES;
        }completion:^(BOOL finished){
            isFullScreen = NO;
            [self enableAllCell];
            preImg = nil;
            [_scrollView setScrollEnabled:YES];
            [_cvImage setScrollEnabled:YES];
            isImageAnimating = NO;
        }];
    }
}

- (void) dismissZoom:(id) sender{
    if(isFullScreen)
        [self imgToFullScreen:preImg withRect:preFrame];
}

- (void) hideAllOtherCell:(int) current{
    for(int i = 0; i < imageList.count; i++){
        if(i != current){
             InputImageCell *cell = (InputImageCell *)[_cvImage cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
                cell.alpha = 0;
            }completion:^(BOOL finished){
            }];
        }
    }
}

- (void) enableAllCell{
    for(int i = 0; i < imageList.count; i++){
        InputImageCell *cell = (InputImageCell *)[_cvImage cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            cell.alpha = 1;
        }completion:^(BOOL finished){
        }];
    }
}
- (void) toggleZoom:(id) sender{
//    NSLog(@"%@", sender);
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if(!isFullScreen){
            CGPoint tappedPoint = [gesture locationInView:_cvImage];
            NSIndexPath *indexPath = [_cvImage indexPathForItemAtPoint:tappedPoint];
            if(indexPath != nil) {
                InputImageCell *cell = (InputImageCell *)[_cvImage cellForItemAtIndexPath:indexPath];
                
                UICollectionViewLayoutAttributes *attributes = [_cvImage layoutAttributesForItemAtIndexPath:indexPath];
                CGRect cellRect = attributes.frame;
                CGRect cellFrameInSuperview = [_cvImage convertRect:cellRect toView:[[_cvImage superview] superview]];
                [self hideAllOtherCell:(int)indexPath.row];
                [self imgToFullScreen:cell.img withRect:cellFrameInSuperview];
            }
        }else{
            [self imgToFullScreen:preImg withRect:preFrame];
        }
        
    }
}

- (IBAction)goBack:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
