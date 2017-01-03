//
//  ReportScreenViewController.m
//  RoadApp
//
//  Created by admin2 on 12/27/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "ReportScreenViewController.h"
#import "SlideMenuViewController.h"
#import "SlideNavigationController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "Utilities.h"
#import "DataTypeItemDb.h"
#import "ReportInformationController.h"
#import "SVProgressHUD.h"
#import "JSONParser.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageDb.h"

@interface ReportScreenViewController (){
    NSMutableArray *dataList, *dataToUpload, *imageToUpload;
    NSString* TOKEN;
}

@end

@implementation ReportScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[MENU_REPORT uppercaseString]];
    [self initLayout];
    [self initData];
}

- (void) initLayout{
    [_cvData registerNib:[UINib nibWithNibName:@"ReportScreenViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReportScreenViewCell"];
    
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 20, [UIScreen mainScreen].bounds.size.height - 44 - 20, 44, 44);
    VCFloatingActionButton *addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"plus"] withScrollview:_cvData];
    addButton.imageArray = @[@"upload"];
    addButton.labelArray = @[@"Upload"];
    addButton.hideWhileScrolling = YES;
    addButton.delegate = self;
    [self.view addSubview:addButton];
}

- (void) initData{
    dataList = [DataTypeItemDb getAllDataTypeItem];
    [_cvData reloadData];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    NSLog(@"Floating action tapped index %tu",row);
    if(row == 0)
       [self uploadData];
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width - 20, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReportScreenViewCell *cell = (ReportScreenViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportScreenViewCell" forIndexPath:indexPath];
    
    cell.topViewOverlay.backgroundColor = [Utilities colorFromHexString:LIGHT_GRAY_COLOR];
    cell.topview.backgroundColor = [Utilities colorFromHexString:LIGHT_GRAY_COLOR];
    cell.topview.layer.cornerRadius = 10.0f;
    cell.btmViewOverlay.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    cell.btmView.backgroundColor = [Utilities colorFromHexString:INPUT_COLOR];
    cell.btmView.layer.cornerRadius = 10.0f;

    DataTypeItemDb *data = [dataList objectAtIndex:indexPath.row];
    cell.lbTime.text = data.thoigiannhap ? [Utilities dateStringFromTimeStamp:data.thoigiannhap] : @"";
    cell.lbDataTypeName.text = data.datatypename ? data.datatypename : @"";
    cell.lbRoadName.text = data.tenduong ? [data.tenduong uppercaseString]: @"";
    cell.lbCategory.text = data.danhgia ? data.danhgia : @"";
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)didSelectItem:(NSIndexPath *)indexPath{
    NSLog(@"Did select: %d", (int) indexPath.row);
    
    DataTypeItemDb *data = [dataList objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReportInformationController *inforVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportInformationController"];
    inforVC.itemModel = data;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:inforVC];
    [self.navigationController presentViewController:navVC animated:YES completion:nil];
//    [self presentViewController:inforVC animated:YES completion:nil];
}


- (IBAction)showSetting:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"CHOOSE REPORT TYPE HERE" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Report diary" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
    
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Collection by road items" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - upload data

- (void) getUserToken{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL, GET_TOKEN_URL];
    [SVProgressHUD showWithStatus:@"Geting token..." maskType:SVProgressHUDMaskTypeBlack];
    [JSONParser getJsonParser:url withParameters:nil success:^(id responseObject) {
        NSLog(@"login response: %@", responseObject);
        
        TOKEN = [[NSString stringWithFormat:@"%@",responseObject] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [[NSUserDefaults standardUserDefaults] setValue:TOKEN forKey:USER_TOKEN];
        [self uploadDataType:dataToUpload];
        
    } failure:^(NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
}

- (void) uploadData{
    dataToUpload = [[NSMutableArray alloc] init];
    imageToUpload = [[NSMutableArray alloc] init];
    for(DataTypeItemDb *data in dataList){
        if([data.isupload intValue] == 0){
            [dataToUpload addObject:data];
            
            NSMutableArray *imgData = [ImageDb findImageWithUUID:data.dataid];
            if(imgData.count > 0){
                [imageToUpload addObjectsFromArray:[imgData mutableCopy]];
            }
        }
    }
    if(dataToUpload.count > 0)
        [self getUserToken];
    else
        [SVProgressHUD dismiss];
}

- (void)uploadDataType:(NSMutableArray *)dataTypeList{
    [SVProgressHUD setStatus:@"Uploading item..."];
    NSString* url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, UPLOAD_DATA_TYPE_URL, TOKEN];
//    
//    [JSONParser postJsonParser:url withParameters:dataTypeList success:^(id responseObject) {
//        [SVProgressHUD dismiss];
//        NSLog(@"reponse: %@", responseObject);
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//        NSLog(@"error: %@", [error localizedDescription]);
//    }];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [NSString stringWithFormat:@"%@", dataToUpload];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%ld",(long)[postData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    
    //Add your request object to an AFHTTPRequestOperation
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *response = [operation responseString];
        NSLog(@"response: %@",response);
        if(imageToUpload.count > 0)
           [self populateImageBeforUpload];
        else
           [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"error: %@", [operation error]);
    }];
    
    //call start on your request operation
    [operation start];
}

- (void) populateImageBeforUpload{
    for(ImageDb *img in imageToUpload){
        [SVProgressHUD setStatus:@"Converting image..."];
        NSURL* aURL = [NSURL URLWithString:img.imagename];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:aURL resultBlock:^(ALAsset *asset)
         {
             UIImage *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:1 orientation:UIImageOrientationUp];
             
             NSString *imgBase64 = [self encodeToBase64String:copyOfOriginalImage];
             img.imagedatabyte = imgBase64;
             img.imagename = [NSString stringWithFormat:@"%@.jpg", [Utilities generateUUID]];
             [self uploadImage:img];
         }
                failureBlock:^(NSError *error)
         {
             // error handling
             NSLog(@"failure-----: %@", [error localizedDescription]);
             [SVProgressHUD dismiss];
         }];
        
    }
    
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void) uploadImage:(ImageDb*) img{
    [SVProgressHUD setStatus:@"Uploading image..."];
    NSString* url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, UPLOAD_IMAGE_URL, TOKEN];
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:img.dataid forKey:@"DataID"];
    [param setObject:img.imagename forKey:@"ImageName"];
    [param setObject:img.imagedatabyte forKey:@"ImageDataByte"];
    
    [JSONParser postJsonParser:url withParameters:param success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"reponse: %@", responseObject);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"error: %@", [error localizedDescription]);
    }];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"POST"];
//    
//    NSString *post = [NSString stringWithFormat:@"%@", dataToUpload];
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%ld",(long)[postData length]];
//    
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
//    [request setHTTPBody:postData];
//    
//    //Add your request object to an AFHTTPRequestOperation
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
//    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [SVProgressHUD dismiss];
//        NSString *response = [operation responseString];
//        NSLog(@"response: %@",response);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD dismiss];
//        NSLog(@"error: %@", [operation error]);
//    }];
    
    //call start on your request operation
//    [operation start];
}
@end
