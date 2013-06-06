//
//  DALoginViewController.h
//  TurnoverIPad
//
//  Created by LI LIN on 2013/05/20.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidFinashLogoutBlock)(void);
typedef void(^DidFinashLoginBlock)(void);

@interface DALoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUserId;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLoginTouched:(id)sender;
- (IBAction)btnLogoutTouched:(id)sender;

@property (strong, nonatomic) DidFinashLogoutBlock didFinashLogout;
@property (strong, nonatomic) DidFinashLoginBlock didFinashLogin;

@end
