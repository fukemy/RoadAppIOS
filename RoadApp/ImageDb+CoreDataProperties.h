//
//  ImageDb+CoreDataProperties.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ImageDb.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageDb (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imagedatabyte;
@property (nullable, nonatomic, retain) NSString *imagename;
@property (nullable, nonatomic, retain) NSString *dataid;

@end

NS_ASSUME_NONNULL_END
