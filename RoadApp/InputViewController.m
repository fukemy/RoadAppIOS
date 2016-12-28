//
//  InputViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface InputViewController ()

@end

@implementation InputViewController{
    bool firstLocationUpdate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    firstLocationUpdate = NO;
    [self setTitle:_titleView];
    [self loadMapView];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [_mapView animateToLocation:newLocation.coordinate];
    // some code...
}

- (void)loadMapView {
    //Controls whether the My Location dot and accuracy circle is enabled.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
    });
    //Controls the type of map tiles that should be displayed.
    
    self.mapView.mapType = kGMSTypeNormal;
    
    //Shows the compass button on the map
    
    self.mapView.settings.compassButton = YES;
    
    //Shows the my location button on the map
    
    self.mapView.settings.myLocationButton = YES;
    
    //Sets the view controller to be the GMSMapView delegate
    
    self.mapView.delegate = self;
    
    [_mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

}

- (void)dealloc {
    [_mapView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
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
