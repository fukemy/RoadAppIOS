//
//  JsonParserWithAF.h
//  CTSDashboard
//
//  Created by Bhoomi Kathiriya on 18/03/15.
//  Copyright (c) 2015 Bhoomi Kathiriya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface JsonParserWithAF : NSObject
{
    
}

@property(nonatomic,strong)NSString *strUserName;
@property(nonatomic,strong)NSString *strPassword;


+ (void)postObject:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;

+ (void)getPath2:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;


+ (void)getPathNew:(NSString *)path
        parameters:(NSMutableArray *)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;

+ (void)getPathSave:(NSString *)path
         parameters:(NSMutableArray *)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;



@end
