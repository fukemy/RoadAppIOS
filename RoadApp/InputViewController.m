//
//  InputViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@implementation InputViewController{
    bool firstLocationUpdate;
    
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.myLocationEnabled = YES;
    _mapView.mapType = kGMSTypeNormal;
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate =  self ;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }else{
        [locationManager startUpdatingLocation];
    }
    [locationManager startUpdatingLocation];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    firstLocationUpdate = NO;
    [self setTitle:_titleView];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"manager");
//    [_mapView animateToLocation:newLocation.coordinate];
//    if(!firstLocationUpdate){
        firstLocationUpdate = YES;
        [_mapView animateToLocation:newLocation.coordinate];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:newLocation.coordinate zoom:14];
//    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"didUpdateToLocation: didChangeAuthorizationStatus");
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {// do some error handling
        }break;
        default:{[locationManager startUpdatingLocation];
        }break;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)dealloc {
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
}

@end
