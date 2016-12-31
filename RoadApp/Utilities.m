//
//  Utilities.m
//  RoadApp
//
//  Created by devil2010 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "Utilities.h"
#import <UIKit/UIKit.h>

@implementation Utilities

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (NSString *)removeString:(NSString *)str byCharacter:(NSString *)character{
    // get all char of string
    if([str length] > 0){
        for (int i = 0; i < [str length]; i++) {
            str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%C", [str characterAtIndex:i]] withString:@""];
        }
    }
    
    return str;
}

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

+ (void)shakeView:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.1;
    animation.byValue = @(2);
    animation.autoreverses = YES;
    animation.repeatCount = INFINITY;
    [view.layer addAnimation:animation forKey:@"Shake"];
}

+ (NSString *) generateUUID{
    return [[NSUUID UUID] UUIDString];
}
@end
