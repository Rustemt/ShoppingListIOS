//
//  DALoginViewController.m
//  TurnoverIPad
//
//  Created by LI LIN on 2013/05/20.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALoginViewController.h"
#import "DAHelper.h"
#import <TribeSDK/TribeSDKHeader.h>

@interface DALoginViewController ()

@end

@implementation DALoginViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.txtUserId becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginTouched:(id)sender
{
    NSString *user = self.txtUserId.text;
    NSString *pass = self.txtPassword.text;
    
    [[DALoginModule alloc] login:user password:pass callback:^(NSError *error, DAUser *user){
        
        NSLog(@"%@", error);
        
        // 保存用户信息
        [[NSUserDefaults standardUserDefaults] setObject:user.uid forKey:kUserDefaultUserID];
        if (self.didFinashLogin != nil) {
            self.didFinashLogin();
        }
        
        // 关闭窗口
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)btnLogoutTouched:(id)sender
{
    // 清除数据
    if (self.didFinashLogout != nil) {
        self.didFinashLogout();
    }
    self.txtPassword.text = @"";
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultUserID];
    
    [[DALoginModule alloc] logout:^(NSError *error){
        // 关闭窗口
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
@end
