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
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    if(indexPath.row == 0){
        MenuTopLayoutTableViewCell *cell = (MenuTopLayoutTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuTopLayoutTableViewCell"];
        cell.imvAvatar.layer.cornerRadius = cell.imvAvatar.frame.size.height / 2;
        cell.imvAvatar.layer.masksToBounds = YES;
        [cell.imvAvatar sd_setImageWithURL:[NSURL URLWithString:@"https://www.google.com/imgres?imgurl=https%3A%2F%2Fi.stack.imgur.com%2Fs3syS.jpg&imgrefurl=http%3A%2F%2Fstackoverflow.com%2Fquestions%2F28631985%2Fhow-to-hide-navigation-bar-and-tab-bar-while-scrolling-table-view-in-ios&docid=Wq7a4CTyWnb_yM&tbnid=tQWOEsVeA2L8KM%3A&vet=1&w=768&h=1024&client=safari&bih=894&biw=1280&q=ios%20navigationbar%20hide%20when%20scroll%20collectionview&ved=0ahUKEwjg74nGkJTRAhXIKpQKHVzpDf0QMwgoKA0wDQ&iact=mrc&uact=8"] placeholderImage:nil completed:nil];
        
        cell.tfName.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell text: %@", cell.textLabel.text);
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainScreen"];
    
//    switch (indexPath.row)
//    {
//        case 0:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//            break;
//            
//        case 1:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
//            break;
//            
//        case 2:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"FriendsViewController"];
//            break;
//            
//        case 3:
//            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
//            return;
//            break;
//    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}

@end
