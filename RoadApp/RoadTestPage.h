//
//  RoadTestPage.h
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoadTestPage : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
-(instancetype)initWithData:(NSArray*)data;
@end
