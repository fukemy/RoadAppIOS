//
//  RoadInformationModel.h
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RoadInformationModel : NSObject

@property long ID;
@property NSString *MaDuong;
@property NSString *TenDuong;
@property NSString *TuyenSo;
@property NSString *TuyenNhanhSo;
@property NSString *CapDuong;
@property int MaDonViQuanLy;
@property int TuCotKm;
@property int DenCotKm;
@property NSString *ViDo;
@property NSString *KinhDo;
@property int ChieuDai;
@property NSString *NgayDieuChinhCotKm;
@property NSString *ThoiDiemCapNhat;
@property int MaTinh;
@property int MaThanhPho;
@property NSString *LoaiLanDuong;
@property int NamXayDung;
@property double HanhLangDuongBo;
@property NSString *LoaiKetCauDuong;
@property int SoLanXeCoGioi;
@property double ChieuRongLanXeCoGioi;
@property NSString *LoaiMatDuongLanXeCoGioi;
@property int SoLanxeThoSo;
@property NSString *LoaiMatDuongLanXeThoSo;
@property double ChieuRongLanXeThoSo;
@property double ChieuRongDuongXeChay;
@property double ChieuRongMatDuong;
@property NSString *LeDuong;
@property double ChieuRongLeDuong;
@property NSString *ViaHe;
@property double ChieuRongViaHe;
@property NSString *LoaiViaHe;
@property double ChieuRongThoatNuoc;
@property double TocDoThietKe;
@property NSString *LoaiDiaHinh;
@property NSString *LoaiNenDuong;

- (instancetype)initWithJSONString:(NSString *)JSONString;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
