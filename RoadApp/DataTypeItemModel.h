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
@property NSString *personMiddleName;
@property NSString *personLastname;

- (instancetype)initWithJSONString:(NSString *)JSONString;
@end
