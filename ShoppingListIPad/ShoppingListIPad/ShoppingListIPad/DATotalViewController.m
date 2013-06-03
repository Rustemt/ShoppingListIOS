//
//  DATotalViewController.m
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DATotalViewController.h"
#import "DATotalViewCell.h"

@interface DATotalViewController ()
{
    NSArray *thePurchase;
}
@end

@implementation DATotalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 50;//thePurchase.count;
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
    if (indexPath.row == 0) {
        cell.lblCol1Name.text = @"肉类";
        cell.lblCol2Name.text = @"蔬菜";
        cell.lblCol3Name.text = @"作料";
        cell.lblCol4Name.text = @"海鲜";
        cell.backgroundColor = [UIColor grayColor];
    }
    
//    if (indexPath.row == 0) {
//        cell.imgCategory.image = [UIImage imageNamed:@"142-wine-bottle.png"];
//    }
//    if (indexPath.row == 1) {
//        cell.imgCategory.image = [UIImage imageNamed:@"125-food.png"];
//    }
//    if (indexPath.row == 2) {
//        cell.imgCategory.image = [UIImage imageNamed:@"88-beer-mug.png"];
//    }
//    if (indexPath.row == 3) {
//        cell.imgCategory.image = [UIImage imageNamed:@"144-martini.png"];
//    }
//    
//    DACategoryItem *item = [theCategory objectAtIndex:indexPath.row];
//    cell.lblName.text = item.name;
//    cell.txtAmount.text = @"0";
//    cell.txtAmount.inputView = dummyKeyboardView; // 不显示键盘
//    [cell.txtAmount addTarget:self action:@selector(amountEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
//    [cell.txtAmount addTarget:self action:@selector(amountEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    return cell;
}

@end
