//
//  DAItemCreateViewController.m
//  ShoppingListIPad
//
//  Created by LI LIN on 2013/06/29.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAItemDetailViewController.h"

@interface DAItemDetailViewController ()
{
    BOOL isNew;
}
@end

@implementation DAItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    isNew = (self.purchase == nil);
    if (!isNew) {
        self.txtName.text = self.purchase.name;
        self.txtAmount.text = self.purchase.amount;
        self.txtUnit.text = self.purchase.unit;
        self.txtProviderName.text = self.purchase.providerName;
        self.txtProviderPhone1.text = self.purchase.providerPhone1;
        self.txtProviderPhone2.text = self.purchase.providerPhone2;
        self.txtProviderDescription.text = self.purchase.providerDescription;
    }
}

- (IBAction)onSaveTouched:(id)sender
{
    if (self.purchase == nil) {
        self.purchase = [[DAPurchase alloc] init];
    }
    
    self.purchase.date = @"";       // 不设定日期
    self.purchase.category = @"0";  // 模板

    self.purchase.name = self.txtName.text;
    self.purchase.amount = self.txtAmount.text;
    self.purchase.unit = self.txtUnit.text;
    self.purchase.providerName = self.txtProviderName.text;
    self.purchase.providerPhone1 = self.txtProviderPhone1.text;
    self.purchase.providerPhone2 = self.txtProviderPhone2.text;
    self.purchase.providerDescription = self.txtProviderDescription.text;
    
    if (isNew) {
        [[DAPurchaseModule alloc]add:self.purchase callback:^(NSError *error, DAPurchase *daily){
            NSLog(@"登陆成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } else {
        [[DAPurchaseModule alloc]update:self.purchase callback:^(NSError *error, DAPurchase *daily){
            NSLog(@"更新成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (IBAction)onDeleteTouched:(id)sender {
}

- (IBAction)textDidEndOnExit:(id)sender
{
    // 移动光标到下一个框
    UITextView *nextTxtView = (UITextView *)[self.view viewWithTag:((UITextView *)sender).tag + 1];
    [nextTxtView becomeFirstResponder];
}

@end
