//
//  DATotalViewController.m
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DATotalViewController.h"
#import "DATotalViewCell.h"
#import "DAHelper.h"

@interface DATotalViewController ()
{
    NSMutableArray *items1;
    NSMutableArray *items2;
    NSMutableArray *items3;
    NSMutableArray *items4;
}
@end

@implementation DATotalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items1 = [[NSMutableArray alloc] initWithObjects: nil];
    items2 = [[NSMutableArray alloc] initWithObjects: nil];
    items3 = [[NSMutableArray alloc] initWithObjects: nil];
    items4 = [[NSMutableArray alloc] initWithObjects: nil];
    
    // 按Category分类数据
    for (DAPurchase *purchase in self.items) {
        switch ([purchase.category integerValue]) {
            case TypeCategoryType1:
                [items1 addObject:purchase];
                break;
            case TypeCategoryType2:
                [items2 addObject:purchase];
                break;
            case TypeCategoryType3:
                [items3 addObject:purchase];
                break;
            case TypeCategoryType4:
                [items4 addObject:purchase];
                break;
        }
    }
}

- (IBAction)onCancelTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 返回最大行数
    NSInteger maxcount = items1.count;
    if (items2.count > maxcount) {
        maxcount = items2.count;
    }
    if (items3.count > maxcount) {
        maxcount = items3.count;
    }
    if (items4.count > maxcount) {
        maxcount = items4.count;
    }
    
    return maxcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DATotalViewCell *cell = (DATotalViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DATotalViewCell"];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"DATotalViewCell" bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    
    cell.lblCol1No.text = [NSString stringWithFormat:@"%02d", indexPath.row + 1];
    cell.lblCol3No.text = [NSString stringWithFormat:@"%02d", indexPath.row + 1];

    if (items1.count > 0) {
        DAPurchase *col1 = [items1 objectAtIndex:indexPath.row];
        cell.lblCol1Name.text = col1.name;
        cell.lblCol1Amount.text = col1.amount;
        cell.lblCol1Unit.text = col1.unit;
        cell.lblCol1Order.text = col1.order;
    }

    if (items2.count > 0) {
        DAPurchase *col2 = [items2 objectAtIndex:indexPath.row];
        cell.lblCol2Name.text = col2.name;
        cell.lblCol2Amount.text = col2.amount;
        cell.lblCol2Unit.text = col2.unit;
        cell.lblCol2Order.text = col2.order;
    }

    if (items3.count > 0) {
        DAPurchase *col3 = [items3 objectAtIndex:indexPath.row];
        cell.lblCol2Name.text = col3.name;
        cell.lblCol2Amount.text = col3.amount;
        cell.lblCol2Unit.text = col3.unit;
        cell.lblCol2Order.text = col3.order;
    }

    if (items4.count > 0) {
        DAPurchase *col4 = [items4 objectAtIndex:indexPath.row];
        cell.lblCol2Name.text = col4.name;
        cell.lblCol2Amount.text = col4.amount;
        cell.lblCol2Unit.text = col4.unit;
        cell.lblCol2Order.text = col4.order;
    }
    
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

@end
