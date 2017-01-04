//
//  ReportPageController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ReportPageController.h"
#import "Constant.h"
#import "Utilities.h"
#import "DataTypeItemModel.h"
#import "ImageModel.h"
#import "InputImageForCell.h"
#import "ImageDb.h"
#import "DataTypeItemDb.h"
#import "SVProgressHUD.h"
#import "MainScreen.h"
#import "KDViewPager.h"

static int const REPORT_TYPE_TAG = 1;
static int const REPORT_LYTRINH_TAG = 2;
static int const REPORT_CONTENT_TAG = 3;

@interface ReportPageController (){
    NSArray *reportTypeList;
    UIPickerView *pickerView;
    UIToolbar *accessoryView;
    UITextField *focusedTextfield;
    NSMutableArray *dataList, *imageList;
    int currentEdit;
    CLLocationManager *locationManager;
}

@end

@implementation ReportPageController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initLayout];
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark - layoutanddata
- (void) initData{
    locationManager = [[CLLocationManager alloc] init];
    currentEdit = 0;
    reportTypeList = [[NSArray alloc] initWithObjects:REPORT_ACCIDENT, REPORT_PROBLEM, REPORT_LAST_DAY, nil];
    
    dataList = [[NSMutableArray alloc] init];
    DataTypeItemModel *firstDataTypeItem = [[DataTypeItemModel alloc] init];
    firstDataTypeItem.DataID = [Utilities generateUUID];
    [dataList addObject:firstDataTypeItem];
    [_cvReport reloadData];
    
    // data for image
    imageList = [[NSMutableArray alloc] init];
    NSMutableArray *firstImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setValue:firstDataTypeItem.DataID  forKey:@"UUID"];
    [imgDict setValue:firstImgArr forKey:@"imageData"];
    
    [imageList addObject:imgDict];
    [_cvReport reloadData];

}

- (void) initLayout{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)]];
    
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    
    if ( accessoryView == nil ) {
        accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                    target:self
                                                                                    action:@selector(doneButton:)];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                      target:self
                                                                                      action:@selector(cancelButton)];
        [accessoryView setItems:@[doneButton, cancelButton]];
        [accessoryView setBackgroundColor:[Utilities colorFromHexString:INPUT_COLOR]];
    }
    
    [_btSave setBackgroundColor:[UIColor redColor]];
    [_btSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btSave setIsRaised:YES];
    _btSave.tapCircleColor = [Utilities colorFromHexString:MAIN_COLOR];
    _btSave.cornerRadius = _btSave.frame.size.width / 2;
    _btSave.rippleFromTapLocation = NO;
    _btSave.rippleBeyondBounds = YES;
    _btSave.tapCircleDiameter = MAX(_btSave.frame.size.width, _btSave.frame.size.height) * 1.6;
    [_btSave addTarget:self action:@selector(saveData:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) endEditing{
    [self.view endEditing:YES];
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
    UICollectionViewCell *cell = [_cvReport cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentEdit inSection:0]];
    [_cvReport setContentOffset:CGPointMake(cell.center.x - _cvReport.frame.size.width * 0.5, cell.frame.origin.y) animated:YES];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
}

#pragma mark - picker delegate
- (void)doneButton:(id)sender{
    [self.view endEditing:YES];
    DataTypeItemModel *model = [dataList objectAtIndex:currentEdit];
    if(focusedTextfield) {
        int selectedIndex;
        if([pickerView selectedRowInComponent:0])
            selectedIndex = (int)[pickerView selectedRowInComponent:0];
        else
            selectedIndex = 0;
        /*
         dont know why picker first item selected return nil??
         */
        focusedTextfield.text = [reportTypeList objectAtIndex:selectedIndex];
        model.DataTypeName = [focusedTextfield text];
    }
    [dataList replaceObjectAtIndex:currentEdit withObject:model];
}

- (void)cancelButton{
    [self.view endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [reportTypeList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [reportTypeList objectAtIndex:row];
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportForInputViewCell *cell = (ReportForInputViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportForInputViewCell" forIndexPath:indexPath];

    cell.layer.cornerRadius = 8.0f;
    cell.tfNumOfImage.layer.cornerRadius = 10;
    cell.tfNumOfImage.layer.masksToBounds = YES;
    cell.tfNumOfVideo.layer.cornerRadius = 10;
    cell.tfNumOfVideo.layer.masksToBounds = YES;
    
    cell.backgroundColor = [Utilities colorFromHexString:LIGHT_GRAY_COLOR];
    
    cell.pkReportType.inputView = pickerView;
    cell.pkReportType.inputAccessoryView = accessoryView;
    if(cell.tvContent.layer){
        cell.tvContent.layer.cornerRadius = 8.0f;
        cell.tvContent.layer.borderWidth = 0.5f;
        cell.tvContent.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    cell.pkReportType.tag = REPORT_TYPE_TAG;
    cell.pkReportType.delegate = self;
    cell.tvContent.delegate = self;
    
    cell.tfLyTrinh.tag = REPORT_LYTRINH_TAG;
    cell.tvContent.tag = REPORT_CONTENT_TAG;
    [cell.tfLyTrinh addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    [cell.tfLyTrinh addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    
    DataTypeItemModel* itemModel = [dataList objectAtIndex:indexPath.row];
    cell.tfLyTrinh.text = itemModel.LyTrinh ? itemModel.LyTrinh : @"";
    cell.tvContent.text = itemModel.MoTaTinhTrang ? itemModel.MoTaTinhTrang : @"";
    cell.pkReportType.text = itemModel.DataTypeName ? itemModel.DataTypeName : @"";
    
    if(itemModel.MoTaTinhTrang)
        [cell.tfPlaceholder setHidden:YES];
    else
        [cell.tfPlaceholder setHidden:NO];
    
    if(!itemModel.KinhDo || !itemModel.ViDo)
        [cell.imgLocationStatus setImage:[UIImage imageNamed:@"warning"]];
    else
        [cell.imgLocationStatus setImage:[UIImage imageNamed:@"check_mark"]];
    
    if(indexPath.row == dataList.count - 1){
        [cell.btAddMoreItem setHidden:NO];
    }else{
        [cell.btAddMoreItem setHidden:YES];
    }
    
    NSMutableArray *imgList = [[imageList objectAtIndex:indexPath.row] objectForKey:@"imageData"];
    if(imgList && imgList.count > 0){
        [cell.tfNumOfImage setHidden:NO];
        [cell.tfNumOfImage setText:[NSString stringWithFormat:@"%d", (int)[imgList count]]];
    }else{
        [cell.tfNumOfImage setHidden:YES];
    }
    [cell.tfNumOfVideo setHidden:YES];
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 316);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}

#pragma mark = text delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField.tag == REPORT_TYPE_TAG){
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    focusedTextfield = textField;
    if(focusedTextfield) {
        UICollectionViewCell *cell = (UICollectionViewCell*)focusedTextfield.superview.superview;
        NSIndexPath *indexPath = [_cvReport indexPathForCell:cell];

        if(focusedTextfield.tag == REPORT_TYPE_TAG){
            [pickerView selectRow:0 inComponent:0 animated:NO];
            currentEdit = (int)indexPath.row;
        }else if(focusedTextfield.tag == REPORT_LYTRINH_TAG){
            if ([focusedTextfield.superview.superview isKindOfClass:[UICollectionViewCell class]])
            {
                NSLog(@"textFieldDidBeginEditing: %d", (int)indexPath.row);
                currentEdit = (int)indexPath.row;
            }
        }
    }
    
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString *targetText = textView.text;
    DataTypeItemModel *model = [dataList objectAtIndex:currentEdit];
    if(textView.tag == REPORT_CONTENT_TAG){
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:currentEdit inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        if([targetText length] > 0){
            [cell.tfPlaceholder setHidden:YES];
        }else{
            [cell.tfPlaceholder setHidden:NO];
        }
        model.MoTaTinhTrang = targetText;
    }
    [dataList replaceObjectAtIndex:currentEdit withObject:model];
}

- (void)textDidChange:(UITextField *)sender {
    NSString *targetText = sender.text;
    DataTypeItemModel *model = [dataList objectAtIndex:currentEdit];
    if(sender.tag == REPORT_LYTRINH_TAG){
        model.LyTrinh = targetText;
    }
    [dataList replaceObjectAtIndex:currentEdit withObject:model];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    UICollectionViewCell *cell = (UICollectionViewCell*)textView.superview.superview;
    NSIndexPath *indexPath = [_cvReport indexPathForCell:cell];
    
    NSLog(@"textViewDidBeginEditing: %d", (int)indexPath.row);
    currentEdit = (int)indexPath.row;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
    locationManager.delegate = nil;
    [locationManager stopUpdatingLocation];
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Failed to Get Your Location"
                                                         delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [SVProgressHUD dismiss];
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        locationManager.delegate = nil;
        [locationManager stopUpdatingLocation];
        NSLog(@"location : %.8f - %.8f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        for(int i = 0; i < dataList.count; i++){
            DataTypeItemModel *itemModel = [dataList objectAtIndex:i];
            itemModel.KinhDo = currentLocation.coordinate.latitude;
            itemModel.ViDo = currentLocation.coordinate.latitude;
            
            NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
            if(cell){
                [cell.imgLocationStatus setImage:[UIImage imageNamed:@"check_mark"]];
            }
        }
    }
}

#pragma mark - cell delegate
-(void)getLocation{
    [SVProgressHUD showWithStatus:@"Updating location" maskType:SVProgressHUDMaskTypeGradient];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

-(void)addMoreInput{
    if(![self checkValidateInput:[dataList lastObject] atIndex:((int) dataList.count - 1)])
        return;
    
    DataTypeItemModel *moreDataTypeItem = [[DataTypeItemModel alloc] init];
    moreDataTypeItem.DataID = [Utilities generateUUID];
    [dataList addObject:moreDataTypeItem];
    [_cvReport reloadData];
    
    NSMutableArray *firstImgArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setValue:moreDataTypeItem.DataID  forKey:@"UUID"];
    [imgDict setValue:firstImgArr forKey:@"imageData"];
    [imageList addObject:imgDict];
    
    [self.view layoutIfNeeded];
    [_cvReport scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:dataList.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    
    currentEdit = currentEdit + 1;
}

-(void)addImageAt:(NSIndexPath *)indexPath withView:(UIView *)view{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InputImageForCell *inputImage = [storyboard instantiateViewControllerWithIdentifier:@"InputImageForCell"];
    currentEdit = (int)indexPath.row;
    inputImage.delegate = self;
    inputImage.UUID = [[imageList objectAtIndex:currentEdit] objectForKey:@"UUID"];
    inputImage.data = [[imageList objectAtIndex:currentEdit] objectForKey:@"imageData"];
    [self presentViewController:inputImage animated:YES completion:nil];
}

-(void)doneAddImage:(NSMutableArray *)dataListArr withUUID:(NSString *)UUID{
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setObject:UUID forKey:@"UUID"];
    [imgDict setObject:dataListArr forKey:@"imageData"];
    [imageList replaceObjectAtIndex:currentEdit withObject:imgDict];
    
    NSMutableArray *imgList = [[imageList objectAtIndex:currentEdit] objectForKey:@"imageData"];
    ReportForInputViewCell *cell = (ReportForInputViewCell *) [_cvReport cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentEdit inSection:0]];
    if(imgList && imgList.count > 0){
        cell.tfNumOfImage.layer.cornerRadius = 10;
        cell.tfNumOfImage.layer.masksToBounds = YES;
        [cell.tfNumOfImage setHidden:NO];
        [cell.tfNumOfImage setText:[NSString stringWithFormat:@"%d", (int) imgList.count]];
        [Utilities showViewWithScaleAnim:cell.tfNumOfImage];
    }else{
        [Utilities hideViewWithScaleAnim:cell.tfNumOfImage];
        [cell.tfNumOfImage setText:[NSString stringWithFormat:@"%d", 0]];
    }
}

- (BOOL) checkValidateInput:(DataTypeItemModel *)itemModel atIndex:(int) index{
    if(!itemModel.DataTypeName){
        [Utilities showSimpleAlert:@"Bạn phải chọn mục báo cáo!" atViewController:self];
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        [_cvReport scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [Utilities shakeView:cell.pkReportType withInfinity:NO];
        return NO;
    }
    
    if(!itemModel.MoTaTinhTrang){
        [Utilities showSimpleAlert:@"Nội dung báo cáo không được để trống!" atViewController:self];
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        [_cvReport scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [Utilities shakeView:cell.tvContent withInfinity:NO];
        return NO;
    }
    
    if(!itemModel.KinhDo || !itemModel.ViDo){
        [Utilities showSimpleAlert:@"Hệ thống không định vị được vị trí của bạn, thử ấn vào tìm vị trí trên bản đồ trước!" atViewController:self];
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        [_cvReport scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [Utilities shakeView:cell.imgLocationStatus withInfinity:NO];
        return NO;
    }
    return YES;
}

- (IBAction)saveData:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message:@"Click OK to finish, dismiss to cancel action."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                                  for(int i = 0; i < dataList.count; i++){
                                                                      DataTypeItemModel *model = [dataList objectAtIndex:i];
                                                                      if(![self checkValidateInput:model atIndex:i])
                                                                          return;
                                                                      model.DanhGia = REPORT;
                                                                      model.MaDuong = -1;
                                                                      model.TuyenSo = -1;
                                                                      model.DataType = -1;
                                                                      
                                                                      NSData *choosenRoad = [[NSUserDefaults standardUserDefaults] objectForKey:ROAD_CHOOSEN];
                                                                      NSDictionary *dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:choosenRoad];
                                                                      RoadInformationModel *roadModel = [[RoadInformationModel alloc] initWithDictionary:dictionary];
                                                                      model.TenDuong = roadModel.TenDuong;
                                                                      
                                                                      for(NSMutableDictionary *imgDict in imageList){
                                                                          NSMutableArray *arrImg = [imgDict objectForKey:@"imageData"];
                                                                          for(NSMutableDictionary *dict in arrImg){
                                                                              if([[imgDict objectForKey:@"UUID"] isEqualToString:model.DataID]){
                                                                                  ImageModel *imageModel = [[ImageModel alloc] init];
                                                                                  imageModel.DataID = [imgDict objectForKey:@"UUID"];
                                                                                  imageModel.ImageName = [dict objectForKey:@"path"];
                                                                                  imageModel.ImageDataByte = @"";
                                                                                  [ImageDb saveImageModel:imageModel];
                                                                              }
                                                                          }
                                                                      }
                                                                      
                                                                      [DataTypeItemDb saveDataTypeItem:model];
                                                                      
                                                                      //chua check xem  co insert ca 2 thanh cong hay ko
                                                                      [self doneSaveData];
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

- (void) doneSaveData{
//    [self initData];
    MainScreen *mainScreen = (MainScreen* )[[self parentViewController] parentViewController];
    [mainScreen switchToFirstPage];
}
@end
