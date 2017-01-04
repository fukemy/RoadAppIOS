//
//  JSONParser.h
//  FamilyRecipe
//
//  Created by Do Thanh Cong on 5/31/16.
//  Copyright © 2016 perceptionsystem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface JSONParser : NSObject

+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params addSubHeader:(NSString *)userIdLogin  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void) postJsonParser:(NSString *)path withParameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void) postJsonParser:(NSString *)path withParameters:(id)params addSubHeader:(NSString *)userIdLogin success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params addUserLogin:(NSString *)userIdLogin andPaging:(NSString*)numpaging success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void) getJsonParser:(NSString *)path withParameters:(id)params withHeaders:(NSArray *)headers success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void) postData:(NSString *)path withParameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
