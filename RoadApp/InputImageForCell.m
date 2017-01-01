//
//  InputImageForCell.m
//  RoadApp
//
//  Created by devil2010 on 12/31/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "InputImageForCell.h"
#import "InputImageCell.h"
#import "Utilities.h"
#import "Constant.h"

#define INTRO_IMAGE @"Một chỉ mục tuần đường tương ứng sẽ có giới hạn 4 ảnh."
#define CONCEPT @"Nhấn add image (+) để thêm ảnh bằng cách chụp hoặc chọn từ thư viện, nhấn vào ảnh và giữ để hiển thị xoá, nhấn cancel để huỷ và nhấn Back để kết thúc bước nhập ảnh."

@implementation InputImageForCell{
    BOOL isActiveDelete;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if(!_data)
        _data = [[NSMutableArray alloc] init];
    isActiveDelete = NO;
    [_cvImg registerNib:[UINib nibWithNibName:@"InputImageCell" bundle:nil] forCellWithReuseIdentifier:@"InputImageCell"];
    
    _tfConcept.text = CONCEPT;
    _tfIntro.text = INTRO_IMAGE;
    [_tfIntro sizeToFit];
    _tfConcept.lineBreakMode = NSLineBreakByWordWrapping;
    _tfConcept.numberOfLines = 0;
    _tfConcept.adjustsFontSizeToFitWidth = YES;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
}

#pragma mark - image cell delegate
-(void)onLongPress:(UILongPressGestureRecognizer *)gr{
    if(isActiveDelete == YES)
        return;
    
    NSIndexPath *indexPath = [_cvImg indexPathForItemAtPoint:[gr locationInView:_cvImg]];
    InputImageCell *cell = (InputImageCell *)[_cvImg cellForItemAtIndexPath:indexPath];
    if(cell.tag == _data.count + 1)
        return;
    
    isActiveDelete = YES;
    [_btBack.titleLabel setText:@"Cancel"];
    [_btBack setTitle:@"Cancel" forState:UIControlStateNormal];
    [_btBack layoutIfNeeded];
    [_cvImg reloadData];
}

-(void)deleteImageAtIndexPath:(NSIndexPath *)indexPath{
    [_cvImg performBatchUpdates:^{
        [_data removeObjectAtIndex:indexPath.row];
        [_cvImg deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:(int)indexPath.row inSection:0]]];
    } completion:^(BOOL finished) {
        if([_data count] == 0){
            isActiveDelete = NO;
            _btBack.titleLabel.text = @"Back";
        }
        [self checkBackButton];
        [_cvImg reloadData];
    }];
}

- (void) initImagePanelWithData:(NSMutableArray *)dataList{
    _data = [[NSMutableArray alloc] initWithArray:dataList];
    [_cvImg reloadData];
}

- (IBAction)dismissView:(id)sender {
    if([_btBack.titleLabel.text isEqualToString:@"Back"]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if([_btBack.titleLabel.text isEqualToString:@"Cancel"]){
        isActiveDelete = NO;
        [_btBack.titleLabel setText:@"Back"];
        [_btBack setTitle:@"Back" forState:UIControlStateNormal];
        [self checkBackButton];
        [_cvImg reloadData];
    }else{
        //push delegate here
        [_delegate doneAddImage:_data withUUID:_UUID];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - table
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = (InputImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"InputImageCell" forIndexPath:indexPath];

    cell.delegate = self;

    if(indexPath.row == _data.count){
        cell.indexPath = nil;
        [cell.img setHidden:YES];
        [cell.imgDelete setHidden:YES];
        
        if([_data count] < 4 && !isActiveDelete)
            [cell.btnAddImage setHidden:NO];
        else
            [cell.btnAddImage setHidden:YES];
        
    }else{
        cell.indexPath = indexPath;
        [cell.img setHidden:NO];
        [cell.btnAddImage setHidden:YES];
        if(!isActiveDelete)
            [cell.imgDelete setHidden:YES];
        else{
            [cell.imgDelete setHidden:NO];
            [Utilities shakeView:cell withInfinity:YES];
        }
        
        if([_data count] > 0 && [_data objectAtIndex:indexPath.row] != [NSNull null]){
            if([[_data objectAtIndex:indexPath.row] objectForKey:@"image"]){
                cell.img.image = [[_data objectAtIndex:indexPath.row] objectForKey:@"image"];
            }else{
                [cell loadImageFromAsset:[[_data objectAtIndex:indexPath.row] objectForKey:@"path"]];
            }
        }
    }
    
    cell.tag = indexPath.row;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width / 3 - 20, self.view.frame.size.width / 3 - 20);
}

#pragma mark - other
- (void) checkBackButton{
    if([_data count] > 0 && !isActiveDelete){
        [_btBack.titleLabel setText:@"Done"];
        [_btBack setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (void)addMoreImage{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
    [dict setObject:image forKey:@"image"];
    [dict setObject:[path relativeString] forKey:@"path"];
    [_data addObject:dict];
    NSLog(@"image path: %@", [_data lastObject]);
    [self checkBackButton];
    [_cvImg reloadData];
}

@end
