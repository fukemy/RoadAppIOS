//
//  SideMenuViewController.m
//  RoadApp
//
//  Created by admin2 on 12/26/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "MFSideMenu.h"

@interface SlideMenuViewController (){
    NSArray *menuItemList;
}

@end

@implementation SlideMenuViewController


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld", (long)section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DemoViewController *demoController = [[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil];
//    demoController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
//    
//    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:demoController];
//    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}


@end
