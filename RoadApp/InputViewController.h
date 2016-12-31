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

@interface InputViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate ,InputCellDelegare
    , UINavigationControllerDelegate>
@property (weak, nonatomic) NSString *titleView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *cvInput;
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;


@end
