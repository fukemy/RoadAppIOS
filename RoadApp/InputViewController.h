//
//  InputViewController.h
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "InputViewCell.h"
#import "InputImageForCell.h"
#import "DataItemModel.h"

@interface InputViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate ,InputCellDelegare
    , UINavigationControllerDelegate, InputImageForCellDelegare, UIScrollViewDelegate>
@property (nonatomic) DataItemModel *dataItemModel;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *cvInput;
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;
@property (assign,nonatomic) CGPoint scrollviewContentOffsetChange;
- (IBAction)saveData:(id)sender;

//extern NSInteger const CATEGORY_TEXTFIELD_PICKER_TAG;
//extern NSInteger const STATUS_TEXTFIELD_PICKER_TAG;
//extern NSInteger const INFOR_TEXTFIELD_INPUT_TAG;
//extern NSInteger const LYTRINH_TEXTFIELD_INPUT_TAG;
@end
