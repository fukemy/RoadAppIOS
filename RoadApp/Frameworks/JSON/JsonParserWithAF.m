//
//  JsonParser.m
//  CTSDashboard
//
//  Created by Bhoomi Kathiriya on 18/03/15.
//  Copyright (c) 2015 Bhoomi Kathiriya. All rights reserved.
//

#import "JsonParserWithAF.h"
#import  "AFNetworking.h"
#import  "AFHTTPRequestOperation.h"

@implementation JsonParserWithAF
@synthesize strUserName;
@synthesize strPassword;

+ (void)postObject:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:path parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         failure(error);
         //....
     }
     ];
}	


+ (void)getPathNew:(NSString *)path
     parameters:(NSMutableArray *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  //  manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:path parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         failure(error);
         //....
     }
     ];
    
    
}


+ (void)getPathSave:(NSString *)path
        parameters:(NSMutableArray *)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
     NSDictionary *params = [[NSDictionary alloc] initWithObjects:@[[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null]] forKeys:parameters];
    [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}



+ (void)getPath2:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:path parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         failure(error);
         //....
     }
     ];
    
    
}


@end
