//
//  DataTypeItemDb+CoreDataProperties.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DataTypeItemDb.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataTypeItemDb (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *dataid;
@property (nullable, nonatomic, retain) NSString *danhgia;
@property (nullable, nonatomic, retain) NSString *nguoinhap;
@property (nullable, nonatomic, retain) NSString *lytrinh;
@property (nullable, nonatomic, retain) NSNumber *caodo;
@property (nullable, nonatomic, retain) NSNumber *vido;
@property (nullable, nonatomic, retain) NSNumber *kinhdo;
@property (nullable, nonatomic, retain) NSString *motatinhtrang;
@property (nullable, nonatomic, retain) NSNumber *tuyenso;
@property (nullable, nonatomic, retain) NSNumber *maduong;
@property (nullable, nonatomic, retain) NSNumber *datatype;
@property (nullable, nonatomic, retain) NSString *thoigiannhap;

@end

NS_ASSUME_NONNULL_END
