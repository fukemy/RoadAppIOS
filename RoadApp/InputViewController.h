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

@interface InputViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate
    , UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate ,InputCellDelegare, UIImagePickerControllerDelegate
    , UINavigationControllerDelegate>
@property (weak, nonatomic) NSString *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tbInput;

@end
