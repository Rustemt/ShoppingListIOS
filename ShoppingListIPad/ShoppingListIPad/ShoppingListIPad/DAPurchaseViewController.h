//
//  DAViewController.h
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDKHeader.h>
#import <UIKit/UIKit.h>

#define kOriginalImage @"ORIGINALIMAGE.JPG"

@interface DAPurchaseViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

- (IBAction)onPrevTouched:(id)sender;
- (IBAction)onNextTouched:(id)sender;
- (IBAction)onCurrentTouched:(id)sender;
- (IBAction)onType1Touched:(id)sender;
- (IBAction)onType2Touched:(id)sender;
- (IBAction)onType3Touched:(id)sender;
- (IBAction)onType4Touched:(id)sender;
- (IBAction)onCompliteTouched:(id)sender;
- (IBAction)onCaptureTouched:(id)sender;
- (IBAction)onDeleteTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barCurrent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderPhone1;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderPhone2;
@property (weak, nonatomic) IBOutlet UITextView *lblProviderDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtRealAmount;
@property (weak, nonatomic) IBOutlet UITextView *txtRealDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgRealImage;

@end
