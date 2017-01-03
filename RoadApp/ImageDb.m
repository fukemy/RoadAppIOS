//
//  ImageDb.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ImageDb.h"
#import "AppDelegate.h"
#import "ImageModel.h"

@implementation ImageDb

// Insert code here to add functionality to your managed object subclass
+ (void) saveImageModel:(ImageModel *) imageModel{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"ImageDb" inManagedObjectContext:context];
    
    
    [transaction setValue:imageModel.DataID forKey:@"dataid"];
    [transaction setValue:imageModel.ImageName forKey:@"imagename"];
    [transaction setValue:imageModel.ImageDataByte forKey:@"imagedatabyte"];
    
    NSLog(@"image model: %@", transaction);
    // Save the context
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        abort();
    }
}

+ (NSMutableArray *) findImageWithUUID:(NSString *) UUID{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ImageDb"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"dataid LIKE %@", UUID]];
    
    NSMutableArray *imgList = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (!results) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    imgList = [[NSMutableArray alloc] initWithArray:results];
    return  imgList;
}
@end
