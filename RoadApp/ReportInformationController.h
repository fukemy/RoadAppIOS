//
//  ReportInformationController.h
//  RoadApp
//
//  Created by devil2010 on 1/2/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DataTypeItemDb.h"
#import "ImageDb.h"

@interface ReportInformationController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewTongQuan;
@property (weak, nonatomic) IBOutlet UIView *viewChiTiest;
@property (weak, nonatomic) IBOutlet UILabel *lbDanhmuc;
@property (weak, nonatomic) IBOutlet UILabel *lbLyTrinh;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbViTri;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbHangMuc;
@property (weak, nonatomic) IBOutlet UILabel *lbTinhTrang;
@property (weak, nonatomic) IBOutlet UILabel *lbMoTaChiTiet;
@property (weak, nonatomic) IBOutlet UICollectionView *cvImage;
@property (weak, nonatomic) IBOutlet UIButton *btDone;
@property (strong, nonatomic) IBOutlet UIView *viewImage;
@property (weak, nonatomic) IBOutlet UILabel *lbImage;
- (IBAction)goBack:(id)sender;

@property (nonatomic) DataTypeItemDb *itemModel;
@end
