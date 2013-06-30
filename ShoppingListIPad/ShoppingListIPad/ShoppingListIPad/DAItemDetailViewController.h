//
//  DAItemCreateViewController.h
//  ShoppingListIPad
//
//  Created by LI LIN on 2013/06/29.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAItemDetailViewController : UIViewController

@property (retain, nonatomic) DAPurchase *purchase;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UITextField *txtUnit;
@property (weak, nonatomic) IBOutlet UITextField *txtProviderName;
@property (weak, nonatomic) IBOutlet UITextField *txtProviderPhone1;
@property (weak, nonatomic) IBOutlet UITextField *txtProviderPhone2;
@property (weak, nonatomic) IBOutlet UITextView *txtProviderDescription;

- (IBAction)onSaveTouched:(id)sender;
- (IBAction)onDeleteTouched:(id)sender;

@end
