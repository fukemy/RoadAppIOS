//
//  DataTypeItemModel.h
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//


//@Override
//public String toString() {
//    return "\n{" +
//    "\n\"DataID\":\"" + DataID + "\"" +
//    ", \n\"DataType\":" + DataType +
//    ", \n\"MaDuong\":" + MaDuong +
//    ", \n\"TuyenSo\":" + TuyenSo +
//    ", \n\"MoTaTinhTrang\":\"" + MoTaTinhTrang + "\"" +
//    ", \n\"KinhDo\":\"" + KinhDo + "\"" +
//    ", \n\"ViDo\":\"" + ViDo + "\"" +
//    ", \n\"CaoDo\":\"" + CaoDo + "\"" +
//    ", \n\"LyTrinh\":\"" + LyTrinh + "\"" +
//    ", \n\"NguoiNhap\":\"" + NguoiNhap + "\"" +
//    ", \n\"ThoiGianNhap\":\"" + ThoiGianNhap + "\""+
//    ", \n\"DanhGia\":\"" + DanhGia + "\""+
//    "\n}";
//}

#import <Foundation/Foundation.h>

@interface DataTypeItemModel : NSObject

@property NSString *DataID;
@property int DataType;
@property NSString *DataTypeName;
@property int MaDuong;
@property NSString *TenDuong;
@property int TuyenSo;
@property NSString *MoTaTinhTrang;
@property float KinhDo;
@property float ViDo;
@property float CaoDo;
@property NSString *LyTrinh;
@property NSString *NguoiNhap;
@property NSString *ThoiGianNhap;
@property NSString *DanhGia;

- (instancetype)initWithJSONString:(NSString *)JSONString;
@end
