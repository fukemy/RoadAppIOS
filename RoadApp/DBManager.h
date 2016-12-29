//
//  DBManager.h
//  RoadApp
//
//  Created by admin2 on 12/29/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
      department:(NSString*)department year:(NSString*)year;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

@end
