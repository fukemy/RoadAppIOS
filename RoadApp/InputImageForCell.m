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

@implementation InputImageForCell


- (void)viewDidLoad{
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    [_cvImg registerNib:[UINib nibWithNibName:@"InputImageCell" bundle:nil] forCellWithReuseIdentifier:@"InputImageCell"];
}


- (void) initImagePanelWithData:(NSMutableArray *)dataList{
    _data = [[NSMutableArray alloc] initWithArray:dataList];
    [_cvImg reloadData];
}

- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InputImageCell *cell = (InputImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"InputImageCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    if(indexPath.row == _data.count){
        [cell.img setHidden:YES];
        [cell.btnAddImage setHidden:NO];
    }else{
        [cell.img setHidden:NO];
        [cell.btnAddImage setHidden:YES];
        if([_data count] > 0 && [_data objectAtIndex:indexPath.row])
            cell.img.image = [_data objectAtIndex:indexPath.row];
        else
            cell.img.image = [UIImage imageNamed:@"male_avtar"];
    }
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width / 3 - 20, self.view.frame.size.width / 3 - 20);
}

-(void)addMoreImage{
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
    
    [_data addObject:image];
    [_cvImg reloadData];
}

@end
