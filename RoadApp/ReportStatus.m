//
//  ViewController.m
//  matyExpandableTableView
//
//  Created by Maitrayee Ghosh on 05/08/14.
//  Copyright (c) 2014 Maitrayee Ghosh. All rights reserved.
//

#import "ReportStatus.h"
#import "Utilities.h"
#import "Constant.h"
#import "DataItemModel.h"
#import "DataTypeItemDb.h"
#import "ReportInformationController.h"

#define DATA_OF_SECTION @"DATA_OF_SECTION"
#define SECTION_ITEM @"SECTION_ITEM"

@interface ReportStatus ()

@end

@implementation ReportStatus

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	// Do any additional setup after loading the view, typically from a nib.
    [self initialization];
}

#pragma  mark - Initialization

-(void)initialization
{
    arrayForBool = [[NSMutableArray alloc] init];
    sectionTitleArray = [[NSMutableArray alloc] init];

    [self getSectionList];
    
}

- (void) getSectionList{
    NSMutableArray *sectionItemList = [Utilities getSectionListItem];
    if(sectionItemList.count > 0){
        for(NSDictionary* dict in sectionItemList){
            DataItemModel* itemSection = [[DataItemModel alloc] initWithDictionary:dict];
            
            //search all item for this datatype
            NSMutableArray* arrForSection = [DataTypeItemDb getDataItemByitemName:itemSection.ItemName];
            //create dict for each data (section + datalist for this section)
            NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
            //add data to section
            [dictData setObject:itemSection.ItemName forKey:SECTION_ITEM];
            //set datatype list
            [dictData setObject:arrForSection forKey:DATA_OF_SECTION];
            
            [sectionTitleArray addObject:dictData];
        }
    }
    
    for (int i=0; i<[sectionTitleArray count]; i++) {
        [arrayForBool addObject:[NSNumber numberWithBool:YES]];
    }
    
    [_expandableTableView reloadData];
}

#pragma mark -
#pragma mark TableView DataSource and Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    if ([[arrayForBool objectAtIndex:section] boolValue]) {
        NSMutableArray* dataForSection = [[sectionTitleArray objectAtIndex:section] objectForKey:DATA_OF_SECTION];
        return [dataForSection count];
//    }
//    else return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"hello";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }

    
        BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
    
             /********** If the section supposed to be closed *******************/
        if(!manyCells)
        {
            cell.backgroundColor=[UIColor clearColor];
            
            cell.textLabel.text=@"";
        }
             /********** If the section supposed to be Opened *******************/
        else
        {
            DataTypeItemDb* rowItem = [[[sectionTitleArray objectAtIndex:indexPath.section] objectForKey:DATA_OF_SECTION] objectAtIndex:indexPath.row];
            cell.textLabel.text=[NSString stringWithFormat:@" %d %@", (int)indexPath.row+1, rowItem.datatypename];
            cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
            cell.backgroundColor=[UIColor whiteColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        }
    cell.textLabel.textColor=[UIColor blackColor];
    
                  /********** Add a custom Separator with cell *******************/
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, _expandableTableView.frame.size.width-15, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:separatorLineView];

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitleArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** Close the section, once the data is selected ***********************************/
//    [arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    
//     [_expandableTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    DataTypeItemDb* rowItem = [[[sectionTitleArray objectAtIndex:indexPath.section] objectForKey:DATA_OF_SECTION] objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReportInformationController *inforVC = [storyboard instantiateViewControllerWithIdentifier:@"ReportInformationController"];
    inforVC.itemModel = rowItem;
    [self presentViewController:inforVC animated:YES completion:nil];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 40;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - Creating View for TableView Section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 30)];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _expandableTableView.frame.size.width, 30)];
    viewLabel.backgroundColor=[Utilities colorFromHexString:@"#10FFFFFF"];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@" %@ (%d)",[[[sectionTitleArray objectAtIndex:section] objectForKey:SECTION_ITEM] uppercaseString],
                    (int) [self tableView:_expandableTableView numberOfRowsInSection:section]];
    [sectionView addSubview:viewLabel];
    
    /********** Add a custom Separator to top Section view *******************/
    if(section != 0){
        UIView* separatorTopLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _expandableTableView.frame.size.width, 1)];
        separatorTopLineView.backgroundColor = [UIColor blackColor];
        [sectionView addSubview:separatorTopLineView];
    }
    
    /********** Add a custom Separator to bottom Section view *******************/
    UIView* separatorBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, _expandableTableView.frame.size.width, 1)];
    separatorBottomLineView.backgroundColor = [UIColor blackColor];
    [sectionView addSubview:separatorBottomLineView];
    
    /********** Add UITapGestureRecognizer to SectionView   **************/
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return sectionView;
    
    
}


#pragma mark - Table header gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[sectionTitleArray count]; i++) {
            if (indexPath.section==i) {
                [arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [_expandableTableView reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
