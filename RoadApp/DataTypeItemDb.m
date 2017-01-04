//
//  DataTypeItemDb.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "DataTypeItemDb.h"
#import "AppDelegate.h"
#import "DataTypeItemModel.h"
#import "Utilities.h"

@implementation DataTypeItemDb

// Insert code here to add functionality to your managed object subclass
+ (void) saveDataTypeItem:(DataTypeItemModel *) dataTypeItemModel{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"DataTypeItemDb" inManagedObjectContext:context];
    
    [transaction setValue:dataTypeItemModel.DataID forKey:@"dataid"];
    [transaction setValue:[NSNumber numberWithInt:dataTypeItemModel.DataType] forKey:@"datatype"];
    [transaction setValue:dataTypeItemModel.DataTypeName forKey:@"datatypename"];
    [transaction setValue:[NSNumber numberWithInt:dataTypeItemModel.MaDuong] forKey:@"maduong"];
    [transaction setValue:dataTypeItemModel.TenDuong forKey:@"tenduong"];
    [transaction setValue:[NSNumber numberWithInt:dataTypeItemModel.TuyenSo] forKey:@"tuyenso"];
    [transaction setValue:dataTypeItemModel.MoTaTinhTrang forKey:@"motatinhtrang"];
    [transaction setValue:[NSNumber numberWithFloat:dataTypeItemModel.KinhDo]  forKey:@"kinhdo"];
    [transaction setValue:[NSNumber numberWithFloat:dataTypeItemModel.ViDo] forKey:@"vido"];
    [transaction setValue:[NSNumber numberWithFloat:dataTypeItemModel.CaoDo] forKey:@"caodo"];
    [transaction setValue:dataTypeItemModel.LyTrinh forKey:@"lytrinh"];
    [transaction setValue:@"dungdv" forKey:@"nguoinhap"];
    [transaction setValue:[Utilities timeStamp] forKey:@"thoigiannhap"];
    [transaction setValue:dataTypeItemModel.DanhGia forKey:@"danhgia"];
    [transaction setValue:@0 forKey:@"isupload"];
    
//    [Utilities toString:dataTypeItemModel];
    NSLog(@"data to save: %@", transaction);
    // Save the context
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
}

+(NSMutableArray *)getAllDataTypeItem{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"DataTypeItemDb"];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (error != nil) {
        return [[NSMutableArray alloc] init];
    }
    else {
        return [[NSMutableArray alloc] initWithArray:results];
    }

}

+ (NSMutableArray *) findDataTypeWithUUID:(NSString *) UUID{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DataTypeItemDb"];
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

+ (void) updateDataTypeWithUUID:(NSString *) UUID{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context =  appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DataTypeItemDb"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"dataid LIKE %@", UUID]];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (results.count > 0) {
        NSManagedObject* favoritsGrabbed = [results objectAtIndex:0];
        [favoritsGrabbed setValue:@1 forKey:@"isupload"];
        [context save:nil];
        NSLog(@"updated data type with UUID: %@", UUID);
    }else{
        NSLog(@"can not find data type with UUID: %@", UUID);
    }
}
@end
