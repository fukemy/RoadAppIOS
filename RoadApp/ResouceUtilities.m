//
//  ResouceUtilities.m
//  RoadApp
//
//  Created by devil2010 on 1/1/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ResouceUtilities.h"
#import "Constant.h"
#import <UIKit/UIKit.h>

@implementation ResouceUtilities


+ (UIImage *)getItemBackground:(int) order{
    switch (order) {
        case 0:
            return [UIImage imageNamed:@"bg_matduong"];
        case 1:
            return [UIImage imageNamed:@"bg_nenduong"];
        case 2:
            return [UIImage imageNamed:@"bg_daiphancach"];
        case 3:
            return [UIImage imageNamed:@"bg_congchuidansinh"];
        case 4:
            return [UIImage imageNamed:@"bg_conghopbanthoatnuoc"];
        case 5:
            return [UIImage imageNamed:@"bg_congtron"];
        case 6:
            return [UIImage imageNamed:@"bg_maidoc"];
        case 7:
            return [UIImage imageNamed:@"bg_tuongchan"];
        case 8:
            return [UIImage imageNamed:@"bg_hangraobaove"];
        case 9:
            return [UIImage imageNamed:@"bg_hethongchieusang"];
        case 10:
            return [UIImage imageNamed:@"bg_bienbao"];
        case 11:
            return [UIImage imageNamed:@"bg_vachsonduong"];
        case 12:
            return [UIImage imageNamed:@"bg_cotkm"];
        case 13:
            return [UIImage imageNamed:@"bg_cau"];
        case 14:
            return [UIImage imageNamed:@"bg_coctieu"];
        case 15:
            return [UIImage imageNamed:@"bg_hogahothu"];
        case 16:
            return [UIImage imageNamed:@"bg_ranhdocranhbien"];
        case 17:
            return [UIImage imageNamed:@"bg_congdoc"];
        default:
            return [UIImage imageNamed:@"bg_nenduong"];
    }

}
+ (NSString* ) plistNameFromCategory:(int )categoryId{
    switch (categoryId) {
        case 0:
            return @"matduong";
        case 1:
            return @"matduong";
        case 2:
            return @"matduong";
        case 3:
            return @"matduong";
        case 4:
            return @"matduong";
        case 5:
            return @"matduong";
        case 6:
            return @"matduong";
        case 7:
            return @"matduong";
        case 8:
            return @"matduong";
        case 9:
            return @"matduong";
        case 10:
            return @"matduong";
        case 11:
            return @"matduong";
        case 12:
            return @"matduong";
        case 13:
            return @"matduong";
        case 14:
            return @"matduong";
        case 15:
            return @"matduong";
        case 16:
            return @"matduong";
        case 17:
            return @"matduong";
            
        default:
            return @"matduong";
    }
}

+ (int ) getDataTypeByItemId:(int )itemId{
    switch (itemId){
        case 1:
            return 0;
        case 2:
            return 8;
        case 3:
            return 13;
        case 4:
            return 16;
        case 5:
            return 31;
        case 6:
            return 47;
        case 7:
            return 62;
        case 8:
            return 67;
        case 9:
            return 75;
        case 10:
            return 79;
        case 11:
            return 86;
        case 12:
            return 89;
        case 13:
            return 92;
        case 14:
            return 95;
        case 15:
            return 104;
        case 16:
            return 108;
        case 17:
            return 115;
        case 18:
            return 120;
        default:
            return 0;
    }
}
@end
