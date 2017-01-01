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

static int const REPORT_TYPE_TAG = 1;
static int const REPORT_LYTRINH_TAG = 2;
static int const REPORT_CONTENT_PLACEHOLDER_TAG = 3;
static int const REPORT_CONTENT_TAG = 4;

@interface ReportPageController (){
    NSArray *reportTypeList;
    UIPickerView *pickerView;
    UIToolbar *accessoryView;
    UITextField *focusedTextfield;
    NSMutableArray *dataList, *imageList;
    int currentEdit;
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

}

- (void) initLayout{
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
//    if (self.view.frame.origin.y >= 0) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 224, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    if (self.view.frame.origin.y < 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 224, self.view.frame.size.width, self.view.frame.size.height);
        }];
        
    }
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportForInputViewCell *cell = (ReportForInputViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportForInputViewCell" forIndexPath:indexPath];

    cell.layer.cornerRadius = 8.0f;
    cell.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    
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
    
    DataTypeItemModel* itemModel = [dataList objectAtIndex:indexPath.row];
    cell.tfLyTrinh.text = itemModel.LyTrinh ? itemModel.LyTrinh : @"";
    cell.tvContent.text = itemModel.MoTaTinhTrang ? itemModel.MoTaTinhTrang : @"";
    cell.pkReportType.text = itemModel.DataTypeName ? itemModel.DataTypeName : @"";
    if(itemModel.MoTaTinhTrang)
        [cell.tfPlaceholder setHidden:YES];
    else
        [cell.tfPlaceholder setHidden:NO];
    
    if(indexPath.row == dataList.count - 1){
        [cell.btAddMoreItem setHidden:NO];
    }else{
        [cell.btAddMoreItem setHidden:YES];
    }
    
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
        if(focusedTextfield.tag == REPORT_TYPE_TAG){
            [pickerView selectRow:0 inComponent:0 animated:NO];
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
#pragma mark - cell delegate
-(void)addMoreInput{
    currentEdit = dataList.count - 1;
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

-(void)doneAddImage:(NSMutableArray *)dataListArr withUUID:(NSString *)UUID{
    NSMutableDictionary *imgDict = [[NSMutableDictionary alloc] init];
    [imgDict setObject:UUID forKey:@"UUID"];
    [imgDict setObject:dataListArr forKey:@"imageData"];
    [imageList replaceObjectAtIndex:currentEdit withObject:imgDict];
}

- (BOOL) checkValidateInput:(DataTypeItemModel *)itemModel atIndex:(int) index{
    if(!itemModel.DataTypeName){
        [Utilities showSimpleAlert:@"Bạn phải chọn mục báo cáo!"];
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        [_cvReport scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [Utilities shakeView:cell.pkReportType withInfinity:NO];
        return NO;
    }
    
    if(!itemModel.MoTaTinhTrang){
        [Utilities showSimpleAlert:@"Nội dung báo cáo không được để trống!"];
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ReportForInputViewCell *cell = (ReportForInputViewCell *)[_cvReport cellForItemAtIndexPath:currentIndexPath];
        [_cvReport scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        [Utilities shakeView:cell.tvContent withInfinity:NO];
        return NO;
    }
    return YES;
}

@end
