//
//  DAItemListViewController.h
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

typedef void (^AddRowDidTouched)(NSArray *selectedItem);

@interface DAItemListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onSelectTouched:(id)sender;

@property (strong, nonatomic) AddRowDidTouched didSelectedBlocks;

@end
