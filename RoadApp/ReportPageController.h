//
//  ReportPageController.h
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportForInputViewCell.h"
#import "InputImageForCell.h"

@interface ReportPageController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, ReportForInputViewCellDelegare, UITextFieldDelegate, UITextViewDelegate, InputImageForCellDelegare>
@property (weak, nonatomic) IBOutlet UICollectionView *cvReport;
@end
