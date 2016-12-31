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
#import "InputImageForCell.h"
#import "WYPopoverController.h"
#import "DataTypeItemModel.h"
#import "DataTypeItemDb.h"
#import "ImageModel.h"
#import "ImageDb.h"

@implementation InputViewController{
    bool firstLocationUpdate;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    UIPickerView *pickerView;
    UIToolbar *accessoryView;
    NSMutableArray *dataList;
    int currentEdit;
    WYPopoverController *popOver;
    NSMutableArray *imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    firstLocationUpdate = NO;
    [self setTitle:_titleView];
    [self initGoogleMap];
    [_cvInput registerNib:[UINib nibWithNibName:@"InputViewCell" bundle:nil] forCellWithReuseIdentifier:@"InputViewCell"];
    [self initPickerAndTable];
    
    [self initFirstData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
    
}

- (void) initFirstData{
    currentEdit = 0;
    
    dataList = [[NSMutableArray alloc] init];
    DataTypeItemModel *firstDataTypeItem = [[DataTypeItemModel alloc] init];
    firstDataTypeItem.DataID = [Utilities generateUUID];
    [dataList addObject:firstDataTypeItem];
    [_cvInput reloadData];
    
    imageList = [[NSMutableArray alloc] init];
    NSMutableArray *firstImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setValue:firstDataTypeItem.DataID  forKey:@"UUID"];
    [imgDict setValue:firstImgArr forKey:@"imageData"];

    [imageList addObject:imgDict];
    
}
#pragma mark - table


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputViewCell *cell = (InputViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"InputViewCell" forIndexPath:indexPath];
    
    cell.rootVIew.layer.cornerRadius = 12.0f;
    [cell.rootVIew setBackgroundColor:[Utilities colorFromHexString:INPUT_COLOR]];
    
    cell.pkRequiredItem.inputView = pickerView;
    cell.pkRequiredItem.inputAccessoryView = accessoryView;
    cell.pkRequiredItem.delegate = self;
    
    cell.pkStatusItem.inputView = pickerView;
    cell.pkStatusItem.inputAccessoryView = accessoryView;
    cell.pkStatusItem.delegate = self;
    
    cell.tfInfor.tag = 0;
    cell.tfLyTrinh.tag = 1;
    [cell.tfInfor addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [cell.tfLyTrinh addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    

    if(indexPath.row == dataList.count - 1)
        [cell.btnAdd setHidden:NO];
    else
        [cell.btnAdd setHidden:YES];
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;

}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    // Add inset to the collection view if there are not enough cells to fill the width.
//    CGFloat cellSpacing = ((UICollectionViewFlowLayout *) collectionViewLayout).minimumLineSpacing;
//    CGFloat cellWidth = ((UICollectionViewFlowLayout *) collectionViewLayout).itemSize.width;
//    NSInteger cellCount = [collectionView numberOfItemsInSection:section];
//    CGFloat inset = (collectionView.bounds.size.width - (cellCount * (cellWidth + cellSpacing))) * 0.5;
//    inset = MAX(inset, 0.0);
//    return UIEdgeInsetsMake(0.0, inset, 0.0, 0.0);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, 230);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float currentPage = _cvInput.contentOffset.x / _cvInput.frame.size.width;
    currentEdit = ceil(currentPage);
    NSLog(@"Values:%d",currentEdit);
}

#pragma InputCell delegate
- (void)addMoreInput{
    DataTypeItemModel *moreDataTypeItem = [[DataTypeItemModel alloc] init];
    moreDataTypeItem.DataID = [Utilities generateUUID];
    [dataList addObject:moreDataTypeItem];
    [_cvInput reloadData];
    
    NSMutableArray *firstImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setValue:moreDataTypeItem.DataID  forKey:@"UUID"];
    [imgDict setValue:firstImgArr forKey:@"imageData"];
    [imageList addObject:imgDict];
    
    [self.view layoutIfNeeded];
    [_cvInput scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:dataList.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    currentEdit ++;
}

-(void) addImageAt:(NSIndexPath *)indexPath withView:(UIView *) view{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InputImageForCell *inputImage = [storyboard instantiateViewControllerWithIdentifier:@"InputImageForCell"];
//    popOver = [[WYPopoverController alloc] initWithContentViewController:inputImage];
//    [inputImage setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//    [popOver presentPopoverFromRect:view.bounds
//                             inView:view
//           permittedArrowDirections:WYPopoverArrowDirectionAny
//                           animated:YES
//                            options:WYPopoverAnimationOptionFadeWithScale];
//    [popOver presentPopoverAsDialogAnimated:YES options:WYPopoverAnimationOptionFadeWithScale];
//    [self.navigationController presentViewController:inputImage animated:YES completion:nil];
//    [self.navigationController pushViewController:inputImage animated:YES];
    currentEdit = (int)indexPath.row;
    inputImage.delegate = self;
    inputImage.UUID = [[imageList objectAtIndex:currentEdit] objectForKey:@"UUID"];
    inputImage.data = [[imageList objectAtIndex:currentEdit] objectForKey:@"imageData"];
    [self presentViewController:inputImage animated:YES completion:nil];
}
#pragma mark - textfield delegate

- (void)textDidChange:(UITextField *)sender {
    NSString *targetText = sender.text;
    DataTypeItemModel *model = [dataList objectAtIndex:currentEdit];
    if(sender.tag == 1){
        model.LyTrinh = targetText;
    }else if(sender.tag == 0){
        model.MoTaTinhTrang = targetText;
    }
    
    [dataList replaceObjectAtIndex:currentEdit withObject:model];
    NSLog(@"text : %@", targetText);
}

#pragma mark - keyboardDelegate
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (self.view.frame.origin.y >= 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 224, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if (self.view.frame.origin.y < 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 224, self.view.frame.size.width, self.view.frame.size.height);
        }];
        
    }
}

#pragma mark -  picker
- (void) initPickerAndTable{
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    
    if ( accessoryView == nil ) {
        accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:@selector(doneButton)];
        [accessoryView setItems:[NSArray arrayWithObject:doneButton]];
        [accessoryView setBackgroundColor:[Utilities colorFromHexString:INPUT_COLOR]];
    }
    
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

#pragma mark - Location

- (void) initGoogleMap{
    _mapView.myLocationEnabled = YES;
    _mapView.mapType = kGMSTypeNormal;
    _mapView.settings.compassButton = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;
    
    
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate =  self ;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
    
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(!firstLocationUpdate){
        
        NSLog(@"updated location");
        firstLocationUpdate = YES;
        [_mapView animateToLocation:newLocation.coordinate];
        _mapView.camera = [GMSCameraPosition cameraWithTarget:newLocation.coordinate zoom:14];
        
        [locationManager stopUpdatingLocation];
        
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
            if (error == nil && [placemarks count] > 0) {
                placemark = [placemarks lastObject];
                
                // strAdd -> take bydefault value nil
                NSString *strAdd = nil;
                
                if ([placemark.subThoroughfare length] != 0)
                    strAdd = placemark.subThoroughfare;
                
                if ([placemark.thoroughfare length] != 0)
                {
                    // strAdd -> store value of current location
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                    else
                    {
                        // strAdd -> store only this value,which is not null
                        strAdd = placemark.thoroughfare;
                    }
                }
                
                if ([placemark.postalCode length] != 0)
                {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                    else
                        strAdd = placemark.postalCode;
                }
                
                if ([placemark.locality length] != 0)
                {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                    else
                        strAdd = placemark.locality;
                }
                
                if ([placemark.administrativeArea length] != 0)
                {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                    else
                        strAdd = placemark.administrativeArea;
                }
                
                if ([placemark.country length] != 0)
                {
                    if ([strAdd length] != 0)
                        strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                    else
                        strAdd = placemark.country;
                }
                _lbLocation.text = strAdd;
                [_lbLocation sizeToFit];
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"didUpdateToLocation: didChangeAuthorizationStatus");
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
        }break;
        default:{
            [locationManager startUpdatingLocation];
        }break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

#pragma mark - image delegate
-(void)doneAddImage:(NSMutableArray *)dataListArr withUUID:(NSString *)UUID{
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setObject:UUID forKey:@"UUID"];
    [imgDict setObject:dataListArr forKey:@"imageData"];
    [imageList replaceObjectAtIndex:currentEdit withObject:imgDict];
    //
}

- (IBAction)saveData:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message:@"Click OK to finish, dismiss to cancel action."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              for(NSMutableDictionary *imgDict in imageList){
                                                                  NSMutableArray *arrImg = [imgDict objectForKey:@"imageData"];
                                                                  for(NSMutableDictionary *dict in arrImg){
                                                                      ImageModel *imageModel = [[ImageModel alloc] init];
                                                                      imageModel.DataID = [imgDict objectForKey:@"UUID"];
                                                                      imageModel.ImageName = [dict objectForKey:@"path"];
                                                                      imageModel.ImageDataByte = @"";
                                                                      [ImageDb saveImageModel:imageModel];
                                                                  }
                                                              }
                                                              
                                                              for(DataTypeItemModel *model in dataList){
                                                                  [DataTypeItemDb saveDataTypeItem:model];
                                                              }
                                                              
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
