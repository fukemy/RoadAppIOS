//
//  ChooseRoad.m
//  RoadApp
//
//  Created by devil2010 on 1/2/17.
//  Copyright © 2017 admin2. All rights reserved.
//

#import "ChooseRoad.h"
#import "Constant.h"
#import "Utilities.h"
#import "RoadInformationModel.h"

@interface ChooseRoad ()

@end

@implementation ChooseRoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _cvRoad.delegate = self;
    _cvRoad.dataSource = self;
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.alpha = 0.6f;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void) initData{
    [_cvRoad reloadData];
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.row == 0){
        cell.textLabel.text = [_dataList objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        NSMutableDictionary *roadDict = [_dataList objectAtIndex:indexPath.row];
        cell.textLabel.text = [roadDict objectForKey:@"TenDuong"];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size: 15.0];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return;
    NSMutableDictionary *dict = [_dataList objectAtIndex:indexPath.row];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:ROAD_CHOOSEN];
    [self dismissViewControllerAnimated:self completion:nil];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return NO;
    return YES;
}

@end
