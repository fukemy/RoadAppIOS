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
@property NSString *DataType;
@property NSString *MaDuong;
@property NSString *TuyenSo;
@property NSString *MoTaTinhTrang;
@property NSString *KinhDo;
@property NSString *ViDo;
@property NSString *CaoDo;
@property NSString *LyTrinh;
@property NSString *NguoiNhap;
@property NSString *ThoiGianNhap;
@property NSString *DanhGia;

- (instancetype)initWithJSONString:(NSString *)JSONString;
@end
