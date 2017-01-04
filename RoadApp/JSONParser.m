//
//  JSONParser.m
//  FamilyRecipe
//
//  Created by Do Thanh Cong on 5/31/16.
//  Copyright © 2016 perceptionsystem. All rights reserved.
//

#import "JSONParser.h"

@implementation JSONParser

+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    [manager setSecurityPolicy:policy];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"dungdv" password:@"12345678"];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *responseData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            success(responseData);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params addSubHeader:(NSString *)userIdLogin  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    [manager setSecurityPolicy:policy];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:userIdLogin forHTTPHeaderField:@"userIdLogin"];
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseParser = [responseObject objectForKey:@"responseVo"];
        int errorResponse = [[responseParser objectForKey:@"error"] intValue];
        if (errorResponse ==1) {
            success(responseObject);
        }else{
            failure([NSError errorWithDomain:[responseParser objectForKey:@"message"] code:1100 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void) getJsonParser:(NSString *)path withParameters:(NSDictionary *)params addUserLogin:(NSString *)userIdLogin andPaging:(NSString*)numpaging success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    [manager setSecurityPolicy:policy];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:userIdLogin forHTTPHeaderField:@"userIdLogin"];
    [manager.requestSerializer setValue:numpaging forHTTPHeaderField:@"numPaging"];
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseParser = [responseObject objectForKey:@"responseVo"];
        int errorResponse = [[responseParser objectForKey:@"error"] intValue];
        if (errorResponse ==1) {
            success(responseObject);
        }else{
            failure([NSError errorWithDomain:[responseParser objectForKey:@"message"] code:1100 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void) getJsonParser:(NSString *)path withParameters:(id)params withHeaders:(NSArray *)headers success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setValidatesDomainName:NO];
    [policy setAllowInvalidCertificates:YES];
    
    [manager setSecurityPolicy:policy];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    for (NSDictionary *headerDictionaries in headers) {
        NSString *keyHeader = [headerDictionaries objectForKey:@"key"];
        NSString *valueHeader = [headerDictionaries objectForKey:@"value"];
        [manager.requestSerializer setValue:valueHeader forHTTPHeaderField:keyHeader];
    }
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseParser = [responseObject objectForKey:@"responseVo"];
        int errorResponse = [[responseParser objectForKey:@"error"] intValue];
        if (errorResponse ==1) {
            success(responseObject);
        }else{
            failure([NSError errorWithDomain:[responseParser objectForKey:@"message"] code:1100 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

+ (void) postJsonParser:(NSString *)path withParameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *responseData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            success(responseData);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failure(error);
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
+ (void) postJsonParser:(NSString *)path withParameters:(id)params addSubHeader:(NSString *)userIdLogin success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:userIdLogin forHTTPHeaderField:@"userIdLogin"];
    
    [manager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseParser = [responseObject objectForKey:@"responseVo"];
        int errorResponse = [[responseParser objectForKey:@"error"] intValue];
        if (errorResponse ==1) {
            success(responseObject);
        }else{
            failure([NSError errorWithDomain:[responseParser objectForKey:@"message"] code:1100 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];

}

/**
 * FOR ROAD PROJECT
 **/

+ (void) postData:(NSString *)path withParameters:(id)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:path]];
        [request setHTTPMethod:@"POST"];
    
        NSString *post = [NSString stringWithFormat:@"%@", params];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%ld",(long)[postData length]];
    
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
        [request setHTTPBody:postData];
    
        //Add your request object to an AFHTTPRequestOperation
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
        [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
            success([[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
        
        //call start on your request operation
        [operation start];
}
@end

