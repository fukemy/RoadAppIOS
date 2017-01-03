//
//  ReportInformationController.h
//  RoadApp
//
//  Created by devil2010 on 1/2/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ReportInformationController : UIViewController

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
@end
