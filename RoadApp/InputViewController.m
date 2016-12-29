//
//  InputViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Utilities.h"
#import "Constant.h"

@implementation InputViewController{
    bool firstLocationUpdate;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    UIPickerView *picker;
    UIToolbar *accessoryView;
    NSMutableArray *dataList;
    int currentEdit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    firstLocationUpdate = NO;
    [self setTitle:_titleView];
//    [self initGoogleMap];
    [_tbInput registerNib:[UINib nibWithNibName:@"InputViewCell" bundle:nil] forCellReuseIdentifier:@"InputViewCell"];
    [self initPickerAndTable];
    
    [self initFirstData];
}

- (void) initFirstData{
    currentEdit = 0;
    
    dataList = [[NSMutableArray alloc] init];
    NSMutableArray *arrImg = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:arrImg forKey:@"image"];
    [dataList addObject:dict];
    
    [_tbInput reloadData];
    
}
#pragma table input

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Tets";
        
        return cell;
    }else{
        
        InputViewCell *cell = (InputViewCell *)[tableView dequeueReusableCellWithIdentifier:@"InputViewCell" forIndexPath:indexPath];
        
        cell.rootVIew.layer.cornerRadius = 5.0f;
//        cell.rootVIew.layer.borderColor = [Utilities colorFromHexString:GRAY_COLOR].CGColor;
//        cell.rootVIew.layer.borderWidth = 1.0f;
//        cell.rootVIew.layer.masksToBounds = YES;
        
        cell.pkRequiredItem.inputView = picker;
        cell.pkRequiredItem.inputAccessoryView = accessoryView;
        cell.pkRequiredItem.delegate = self;
        
        cell.pkStatusItem.inputView = picker;
        cell.pkStatusItem.inputAccessoryView = accessoryView;
        cell.pkStatusItem.delegate = self;
        
        if(indexPath.row == dataList.count)
           [cell.btnAdd setHidden:NO];
        else
            [cell.btnAdd setHidden:YES];
        
        
        cell.delegate = self;
        NSMutableDictionary *dict = [dataList objectAtIndex:indexPath.row - 1];
        NSMutableArray *arr = [dict objectForKey:@"image"];
        CGRect frame;
        if(arr == nil || [arr count] == 0){
            cell.viewImage.hidden = YES;
            frame = cell.viewImage.frame;
            frame.size.height = 0;
            cell.viewImage.frame = frame;
    
        }else{
            cell.viewImage.hidden = NO;
            frame = cell.viewImage.frame;
            frame.size.height = 72;
            cell.viewImage.frame = frame;
            
            UIImage *image = [UIImage imageWithContentsOfFile:[arr objectAtIndex:0]];
            [cell.viewImage addSubview:image];
        }
        
        
        CGRect frame1 = cell.rootVIew.frame;
        frame1.size.height = frame1.size.height - (frame.size.height == 0 ? 70 : 0);
        cell.rootVIew.frame = frame1;
        
        CGRect frame2 = cell.inputView.frame;
        frame2.size.height = frame2.size.height - (frame.size.height == 0 ? 70 : 0);
        cell.inputView.frame = frame2;

        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 44;
    }else{
        
        NSMutableDictionary *dict = [dataList objectAtIndex:indexPath.row - 1];
        NSMutableArray *arr = [dict objectForKey:@"image"];
        if(arr == nil || [arr count] == 0){
            return  225;
        }else{
            return 70 + 225;
        }
    }
}

#pragma InputCell delegate
- (void)addMoreInput{
    NSMutableArray *arrImg = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:arrImg forKey:@"image"];
    [dataList addObject:dict];
    [_tbInput reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[dataList count] inSection:0];
    [_tbInput scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void) addImage:(NSIndexPath *)indexPath{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    currentEdit = (int)indexPath.row;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma picker
- (void) initPickerAndTable{
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [picker setShowsSelectionIndicator:YES];
    [picker setBackgroundColor:[UIColor whiteColor]];
    
    if ( accessoryView == nil ) {
        accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:@selector(doneButton)];
        [accessoryView setItems:[NSArray arrayWithObject:doneButton]];
        [accessoryView setBackgroundColor:[Utilities colorFromHexString:INPUT_COLOR]];
    }
    
    _tbInput.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbInput.separatorColor = [UIColor clearColor];
}

- (void)doneButton{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"picker";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    [[self view] endEditing:YES];
}

#pragma Location
//
//- (void) initGoogleMap{
//    _mapView.myLocationEnabled = YES;
//    _mapView.mapType = kGMSTypeNormal;
//    _mapView.settings.compassButton = YES;
//    _mapView.settings.myLocationButton = YES;
//    _mapView.delegate = self;
//    
//    
//    geocoder = [[CLGeocoder alloc] init];
//    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate =  self ;
//    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
//        [locationManager requestWhenInUseAuthorization];
//        [locationManager requestAlwaysAuthorization];
//    }
//    
//    [locationManager startUpdatingLocation];
//}
//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    if(!firstLocationUpdate){
//        
//        NSLog(@"updated location");
//        firstLocationUpdate = YES;
//        [_mapView animateToLocation:newLocation.coordinate];
//        _mapView.camera = [GMSCameraPosition cameraWithTarget:newLocation.coordinate zoom:14];
//        
//        [locationManager stopUpdatingLocation];
//        
//        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//            if (error == nil && [placemarks count] > 0) {
//                placemark = [placemarks lastObject];
//                
//                // strAdd -> take bydefault value nil
//                NSString *strAdd = nil;
//                
//                if ([placemark.subThoroughfare length] != 0)
//                    strAdd = placemark.subThoroughfare;
//                
//                if ([placemark.thoroughfare length] != 0)
//                {
//                    // strAdd -> store value of current location
//                    if ([strAdd length] != 0)
//                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
//                    else
//                    {
//                        // strAdd -> store only this value,which is not null
//                        strAdd = placemark.thoroughfare;
//                    }
//                }
//                
//                if ([placemark.postalCode length] != 0)
//                {
//                    if ([strAdd length] != 0)
//                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
//                    else
//                        strAdd = placemark.postalCode;
//                }
//                
//                if ([placemark.locality length] != 0)
//                {
//                    if ([strAdd length] != 0)
//                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
//                    else
//                        strAdd = placemark.locality;
//                }
//                
//                if ([placemark.administrativeArea length] != 0)
//                {
//                    if ([strAdd length] != 0)
//                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
//                    else
//                        strAdd = placemark.administrativeArea;
//                }
//                
//                if ([placemark.country length] != 0)
//                {
//                    if ([strAdd length] != 0)
//                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
//                    else
//                        strAdd = placemark.country;
//                }
//                _lbLocation.text = strAdd;
//                [_lbLocation sizeToFit];
//            } else {
//                NSLog(@"%@", error.debugDescription);
//            }
//        } ];
//    }
//}
//
//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    NSLog(@"didUpdateToLocation: didChangeAuthorizationStatus");
//    switch (status) {
//        case kCLAuthorizationStatusNotDetermined:
//        case kCLAuthorizationStatusRestricted:
//        case kCLAuthorizationStatusDenied:
//        {
//        }break;
//        default:{
//            [locationManager startUpdatingLocation];
//        }break;
//    }
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *dict = [dataList objectAtIndex:currentEdit];
    NSMutableArray *arr = [dict objectForKey:@"image"];
    [arr addObject:[path relativeString]];
    
    [dict setObject:arr forKey:@"image"];
    
    [dataList replaceObjectAtIndex:currentEdit withObject:dict];
    
    [_tbInput reloadData];
}

@end
