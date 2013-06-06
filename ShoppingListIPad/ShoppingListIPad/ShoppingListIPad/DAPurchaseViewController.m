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
#import "DALoginViewController.h"

@interface DAPurchaseViewController ()
{
    NSArray *items;
}

@end

@implementation DAPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.barCurrent.title = [DAHelper getDayString:[NSDate date]];

    // 当前用户有效，则获取数据
    if ([DAHelper getCurrentUser] != nil) {
        [self getPurchaseData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // 如果没有登陆，显示登陆画面
    if ([DAHelper getCurrentUser] == nil) {
        DALoginViewController *loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DALoginViewController"];
        [loginViewController setModalPresentationStyle:UIModalPresentationFormSheet];
        [loginViewController setDidFinashLogin:^{
            [self getPurchaseData];
        }];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }

}

- (void)getPurchaseData
{
    [[DAPurchaseModule alloc] getByDate:self.barCurrent.title callback:^(NSError *error, DAPurchase *daily){
        items = daily.items;
        [self.tableView reloadData];
    }];
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
    
    DAPurchaseItem *item = [items objectAtIndex:indexPath.row];
    
    cell.lblNo.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.lblName.text = item.name;
    cell.lblAmount.text = item.amount;
    cell.lblUnit.text = item.unit;
    cell.lblPhone.text = item.providerPhone1;
    
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
    DAPurchase *purchase = [[DAPurchase alloc] init];
    purchase.date = self.barCurrent.title;
    
    DAPurchaseItem *item = [[DAPurchaseItem alloc] init];
    item.amount = @"12345";
    item.name = @"lalala";
    purchase.items = [[NSArray alloc] initWithObjects:item, nil];

    [[DAPurchaseModule alloc]update:purchase callback:^(NSError *error, DAPurchase *daily){}];
//    [[DAPurchaseModule alloc]add:purchase callback:^(NSError *error, DAPurchase *daily){}];
}
@end
