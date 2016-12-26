//
//  RoadTestPage.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "RoadTestPage.h"
#import "RoadTestCell.h"

@interface RoadTestPage ()

@end

@implementation RoadTestPage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithData:(NSArray*)data{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RoadTestPage" owner:self options:nil];
        UIView *view = (UIView *)[nib objectAtIndex:0];
        view.frame = self.view.bounds;
        view.backgroundColor = [UIColor clearColor];
        //[self.view addSubview:view];
    }
    return self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RoadTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoadTestCell" forIndexPath:indexPath];
    
    cell.tfTitle.text = @"test";
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
