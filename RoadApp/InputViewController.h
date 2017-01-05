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
#import "BFPaperButton.h"

@interface InputViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate ,InputCellDelegare
    , UINavigationControllerDelegate, InputImageForCellDelegare, UIScrollViewDelegate, BFPagerButtonDelegate>
@property (nonatomic) DataItemModel *dataItemModel;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *cvInput;
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;
@property (assign,nonatomic) CGPoint scrollviewContentOffsetChange;
- (IBAction)saveData:(id)sender;
@property (weak, nonatomic) IBOutlet BFPaperButton *btSave;

@end
