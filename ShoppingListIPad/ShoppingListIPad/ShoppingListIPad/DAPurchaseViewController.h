//
//  DAViewController.h
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDKHeader.h>
#import <UIKit/UIKit.h>

@interface DAPurchaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barCurrent;
- (IBAction)onPrevTouched:(id)sender;
- (IBAction)onNextTouched:(id)sender;
- (IBAction)onCurrentTouched:(id)sender;

- (IBAction)onType1Touched:(id)sender;
- (IBAction)onType2Touched:(id)sender;
- (IBAction)onType3Touched:(id)sender;
- (IBAction)onType4Touched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderPhone1;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderPhone2;
@property (weak, nonatomic) IBOutlet UITextView *lblProviderDescription;
- (IBAction)onCompliteTouched:(id)sender;

@end
