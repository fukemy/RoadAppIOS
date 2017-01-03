//
//  ImageDb.h
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ImageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ImageDb : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (void) saveImageModel:(ImageModel *) imageModel;
+ (NSMutableArray *) findImageWithUUID:(NSString *) UUID;
@end

NS_ASSUME_NONNULL_END

#import "ImageDb+CoreDataProperties.h"
