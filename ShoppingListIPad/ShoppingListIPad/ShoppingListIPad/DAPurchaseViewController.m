//
//  DAViewController.m
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPurchaseViewController.h"
#import "DAPurchaseViewCell.h"
#import "DAHelper.h"

@interface DAPurchaseViewController ()
{
    NSArray *items;
    NSArray *amounts;
    NSArray *units;
}

@end

@implementation DAPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items = [NSArray arrayWithObjects:@"螃蟹", @"韭菜", @"大料", @"色拉油", @"白菜", @"螃蟹", @"韭菜", @"大料", @"色拉油", @"白菜", @"螃蟹", @"韭菜", @"大料", @"色拉油", @"白菜", nil];
    amounts = [NSArray arrayWithObjects:@"100", @"5", @"30", @"2,000", @"100", @"100", @"5", @"30", @"2,000", @"100", @"100", @"5", @"30", @"2,000", @"100", nil];
    units = [NSArray arrayWithObjects:@"公斤", @"公斤", @"公斤", @"桶", @"颗", @"公斤", @"公斤", @"公斤", @"桶", @"颗", @"公斤", @"公斤", @"公斤", @"桶", @"颗", nil];
    
    self.barCurrent.title = [DAHelper getDayString:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *identifier = @"DAPurchaseViewCell";
    
    DAPurchaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DAPurchaseViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.lblNo.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.lblName.text = [items objectAtIndex:indexPath.row];
    cell.lblAmount.text = [amounts objectAtIndex:indexPath.row];
    cell.lblUnit.text = [units objectAtIndex:indexPath.row];
    cell.lblPhone.text = @"186-1234-5678";
    
    cell.contentView.backgroundColor = [UIColor colorWithHue:0.21
                                                  saturation:0.09
                                                  brightness:0.99
                                                       alpha:1.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)purchaseViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}


- (IBAction)onPrevTouched:(id)sender
{
    NSDate *current = [DAHelper addDay:[DAHelper stringToDate:self.barCurrent.title] day:-1];
    
    self.barCurrent.title = [DAHelper getDayString:current];
}

- (IBAction)onNextTouched:(id)sender
{
    NSDate *current = [DAHelper addDay:[DAHelper stringToDate:self.barCurrent.title] day:1];
    
    self.barCurrent.title = [DAHelper getDayString:current];
}

- (IBAction)onCurrentTouched:(id)sender
{
    self.barCurrent.title = [DAHelper getDayString:[NSDate date]];

}

- (IBAction)onType1Touched:(id)sender
{
}

- (IBAction)onType2Touched:(id)sender
{
}

- (IBAction)onType3Touched:(id)sender
{
}

- (IBAction)onType4Touched:(id)sender
{
}
- (IBAction)onCompliteTouched:(id)sender
{
}
@end
