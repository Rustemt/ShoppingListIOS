//
//  DAItemListCell.h
//  ShoppingListIPad
//
//  Created by LI LIN on 2013/06/29.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAItemListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblProviderName;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;

@end
