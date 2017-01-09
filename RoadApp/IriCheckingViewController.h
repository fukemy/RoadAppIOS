//
//  IriCheckingViewController.h
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BEMSimpleLineGraphView.h"
#import <GoogleMaps/GoogleMaps.h>


@interface IriCheckingViewController : UIViewController <SlideNavigationControllerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong, nonatomic) NSMutableData *data;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *lbIndicator;
@end
