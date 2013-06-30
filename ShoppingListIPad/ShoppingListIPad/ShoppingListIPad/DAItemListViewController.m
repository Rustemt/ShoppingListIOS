//
//  DAItemListViewController.m
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAItemListViewController.h"
#import "DAItemListCell.h"
#import "DAItemDetailViewController.h"

@interface DAItemListViewController ()
{
    NSArray *items;
}

@end

@implementation DAItemListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[[DAPurchaseModule alloc] getTemplate:^(NSError *error, DAPurchaseList *list){
        items = list.items;
        [self.tableView reloadData];
    }];
}

// 详细画面返回
- (IBAction)itemListViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DAItemListViewCell";
    
    DAItemListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DAItemListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    DAPurchase *item = [items objectAtIndex:indexPath.row];
    
    cell.lblNo.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.lblName.text = item.name;
    cell.lblProviderName.text = item.providerName;
    
    cell.btnDetail.tag = indexPath.row;
    [cell.btnDetail addTarget:self action:@selector(onDetailTouched:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.contentView.backgroundColor = [UIColor colorWithHue:0.21
                                                  saturation:0.09
                                                  brightness:0.99
                                                       alpha:1.0];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

// 详细按钮
- (void)onDetailTouched:(UIButton *)control withEvent:event
{
    DAItemDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DAItemDetailViewController"];
    NSLog(@"%d", control.tag);
    detailViewController.purchase = [items objectAtIndex:control.tag];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (IBAction)onSelectTouched:(id)sender
{
    if (self.didSelectedBlocks != nil) {
        
        NSMutableArray *selected = [[NSMutableArray alloc] initWithObjects:nil];

        for (NSInteger i = 0; i < [self.tableView numberOfRowsInSection:0]; ++i) {
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                [selected addObject:[items objectAtIndex:i]];
            }
        }
        
        self.didSelectedBlocks(selected);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
