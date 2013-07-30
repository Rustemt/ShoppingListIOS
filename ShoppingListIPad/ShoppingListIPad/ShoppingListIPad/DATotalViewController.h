//
//  DATotalViewController.h
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DATotalViewController : UIViewController

@property (retain, nonatomic) NSArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onCancelTouched:(id)sender;

@end
