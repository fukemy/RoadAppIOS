//
//  SideMenuViewController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "MFSideMenu.h"
#import "SlideNavigationController.h"
#import "MenuTopLayoutTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "MenuItem.h"
#import "ReportDiary.h"
#import "AppDelegate.h"
#import "MapViewController.h"
#import "IriCheckingViewController.h"
#import "Utilities.h"
#import "VideoViewController.h"

@interface SlideMenuViewController (){
    NSArray *menuItemList;
}

@end

@implementation SlideMenuViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    menuItemList = [[NSArray alloc] initWithObjects:@"", MENU_MAIN_SCREEN, MENU_ICI_CHECKING, MENU_REPORT, MENU_MAP, MENU_VIDEO, nil];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        MenuTopLayoutTableViewCell *cell = (MenuTopLayoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuTopLayoutTableViewCell"];
        cell.imvAvatar.layer.cornerRadius = 35;
        cell.imvAvatar.layer.masksToBounds = YES;
        cell.imvAvatar.layer.borderColor = [Utilities colorwithHexString:@"FFFFFF" alpha:0.3f].CGColor;
        cell.imvAvatar.layer.borderWidth = 2.0f;
        
        [cell.imvAvatar sd_setImageWithURL:[NSURL URLWithString:@"https://i.stack.imgur.com/KC3mu.png"] placeholderImage:[UIImage imageNamed:@"male_avtar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!error){
                cell.imvAvatar.image = image;
            }else{
                NSLog(@"error load avatar: %@", [error localizedDescription]);
            }
        }];
        
        cell.tfName.text = @"Đỗ Việt Dũng";
        cell.tfPosition.text = @"Nhân viên";
        [cell setUserInteractionEnabled:NO];
        return cell;
        
    }else{
        MenuItem *cell = (MenuItem *)[tableView dequeueReusableCellWithIdentifier:@"MenuItem"];
        cell.tfMenuName.text = [menuItemList objectAtIndex:(long)indexPath.row];
        cell.imvMenu.image = [self imageForCell:(long)indexPath.row];
        cell.tfMenuName.textColor = [UIColor whiteColor];
        
        return cell;
        
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    if(indexPath.row == 0)
        return;
    MenuItem *cell = (MenuItem *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [Utilities colorwithHexString:@"FFFFFF" alpha:0.05f];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    if(indexPath.row == 0)
        return;
    MenuItem *cell = (MenuItem *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

- (UIImage *) imageForCell:(long) row{
    switch (row) {
        case 1:
            return [UIImage imageNamed:@"MENU_MAIN_SCREEN"];
        case 2:
            return [UIImage imageNamed:@"MENU_ICI_CHECKING"];
        case 3:
            return [UIImage imageNamed:@"MENU_REPORT"];
        case 4:
            return [UIImage imageNamed:@"MENU_MAP"];
        case 5:
            return [UIImage imageNamed:@"MENU_VIDEO"];
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 200;
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return;
    
    MenuItem *cell = (MenuItem *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell text: %@", cell.tfMenuName.text);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *vc;
    switch (indexPath.row)
    {
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MainScreen"];
            break;
            
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"IriCheckingViewController"];
            break;
            
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ReportController"];
            break;
            
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MapViewController"];
            break;
            
        case 5:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"VideoViewController"];
            break;
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
    
}

- (IBAction)goSeting:(id)sender {
}

- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:USER_LOGGED];
//    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:NO];
}
@end
