//
//  DAViewController.m
//  PurchaseListIPad
//
//  Created by LI LIN on 2013/05/01.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPurchaseViewController.h"
#import "DAPurchaseViewCell.h"
#import "DAHelper.h"
#import "DALoginViewController.h"
#import "DAItemListViewController.h"
#import "DATotalViewController.h"


@interface DAPurchaseViewController ()
{
    NSMutableArray *items;
    NSMutableArray *allitems;
    TypeCategory currentType;
    
    UIPopoverController *_popover;

}

@end

@implementation DAPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    currentType = TypeCategoryType1;
    self.barCurrent.title = [DAHelper getDayString:[NSDate date]];

    // 当前用户有效，则获取数据
    if ([DAHelper getCurrentUser] != nil) {
        [self getPurchaseData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // 如果没有登陆，显示登陆画面
    if ([DAHelper getCurrentUser] == nil) {
        DALoginViewController *loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DALoginViewController"];
        [loginViewController setModalPresentationStyle:UIModalPresentationFormSheet];
        [loginViewController setDidFinashLogin:^{
            [self getPurchaseData];
        }];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)getPurchaseData
{
    [[DAPurchaseModule alloc] getByDate:self.barCurrent.title callback:^(NSError *error, DAPurchaseList *daily){
        allitems = [[NSMutableArray alloc] initWithArray:daily.items];
        [self showTableData];
    }];
}

- (void)showTableData
{
    // 过滤显示用数据，只留下当前选中的类别
    items = [[NSMutableArray alloc] initWithObjects: nil];
    for (DAPurchase *purchase in allitems) {
        if ([purchase.category integerValue] == currentType) {
            [items addObject:purchase];
        }
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DAPurchaseViewCell";
    
    DAPurchaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DAPurchaseViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    DAPurchase *item = [items objectAtIndex:indexPath.row];
    
    cell.lblNo.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.lblName.text = item.name;
    cell.lblAmount.text = item.amount;
    cell.lblUnit.text = item.unit;
    cell.lblPhone.text = item.providerPhone1;
    
    cell.contentView.backgroundColor = [UIColor colorWithHue:0.21
                                                  saturation:0.09
                                                  brightness:0.99
                                                       alpha:1.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:[items objectAtIndex:indexPath.row]];
}

- (void)showDetail:(DAPurchase *)purchase
{
    self.lblProviderName.text = purchase.providerName;
    self.lblProviderPhone1.text = purchase.providerPhone1;
    self.lblProviderPhone2.text = purchase.providerPhone2;
    self.lblProviderDescription.text = purchase.providerDescription;
    
    self.txtRealAmount.text = purchase.realAmount;
    self.txtRealDescription.text = purchase.realDescription;
    self.imgRealImage.image = [UIImage imageNamed:@"Default.png"];
}


- (IBAction)purchaseViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}


// 前日
- (IBAction)onPrevTouched:(id)sender
{
    NSDate *current = [DAHelper addDay:[DAHelper stringToDate:self.barCurrent.title] day:-1];
    self.barCurrent.title = [DAHelper getDayString:current];
    [self getPurchaseData];
}

// 次日
- (IBAction)onNextTouched:(id)sender
{
    NSDate *current = [DAHelper addDay:[DAHelper stringToDate:self.barCurrent.title] day:1];
    self.barCurrent.title = [DAHelper getDayString:current];
    [self getPurchaseData];
}

// 今日
- (IBAction)onCurrentTouched:(id)sender
{
    self.barCurrent.title = [DAHelper getDayString:[NSDate date]];

}

- (IBAction)onType1Touched:(id)sender
{
    currentType = TypeCategoryType1;
    [self showTableData];
}

- (IBAction)onType2Touched:(id)sender
{
    currentType = TypeCategoryType2;
    [self showTableData];
}

- (IBAction)onType3Touched:(id)sender
{
    currentType = TypeCategoryType3;
    [self showTableData];
}

- (IBAction)onType4Touched:(id)sender
{
    currentType = TypeCategoryType4;
    [self showTableData];
}

- (IBAction)onCompliteTouched:(id)sender
{
    DAPurchase *purchase = [[DAPurchase alloc] init];
    purchase.date = self.barCurrent.title;
    
    DAPurchase *item = [[DAPurchase alloc] init];
    item.amount = @"12345";
    item.name = @"lalala";
    
    [[DAPurchaseModule alloc]add:purchase callback:^(NSError *error, DAPurchase *daily){
        NSLog(@"asdfad");
    }];

//    [[DAPurchaseModule alloc]update:purchase callback:^(NSError *error, DAPurchase *daily){
//        NSLog(@"asdfad");
//    }];
}

- (IBAction)onCaptureTouched:(id)sender
{
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    // イメージピッカーを作る
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = NO;
    
    // イメージピッカーを表示する
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (IBAction)onDeleteTouched:(id)sender {
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 明细管理
    if ([[segue identifier] isEqualToString:@"DAItemListViewControllerSegue"]) {
        // 获取Controller
        UINavigationController *navigation = (UINavigationController *)[segue destinationViewController];
        DAItemListViewController *itemListViewController = (DAItemListViewController *)[[navigation viewControllers] lastObject];
        
        // 设定选择回调块
        itemListViewController.didSelectedBlocks = ^(NSArray *selecteditems){
            
            __block NSInteger updateIndex = 0;
            
            // 保存到数据库
            DAPurchaseModule *module = [DAPurchaseModule alloc];
            for (NSInteger i = 0; i < items.count; i++) {
                
                // 设定分类
                DAPurchase *object = [items objectAtIndex:i];
                object.category = [NSString stringWithFormat:@"%d", currentType];
                [module add:object callback:^(NSError *error, DAPurchase *daily){
                    updateIndex = updateIndex + 1;
                    
                    // 全部更新完，刷新画面
                    if (updateIndex >= items.count) {
                        [items addObjectsFromArray:items];
                        [self.tableView reloadData];
                    }
                }];
            }
        };
    }
    
    // 查看汇总
    if ([[segue identifier] isEqualToString:@"DATotalViewControllerSegue"]) {
        DATotalViewController *totalViewController = (DATotalViewController *)[segue destinationViewController];
        totalViewController.items = allitems;
    }

}

#pragma mark - Camera delegate methods

// カメラの画像を取得した場合の処理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (_popover.popoverVisible) {
        [_popover dismissPopoverAnimated:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 動画で画像サイズを調整
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // オリジナル画像をリセット時使用するため、ファイルに一時的に保存する
    NSData *data = UIImageJPEGRepresentation(originalImage, 1);
    [data writeToFile:[DAHelper fullPath:kOriginalImage] atomically:YES];
//    canvasImageView.isImageSelected = YES;
    
    // 画像の背景フレームサイズを調整し、画像を表示する
    [DAHelper changeImageViewSize:self.imgRealImage originalImageSize:originalImage.size frame:CGRectMake(607.0f, 391.0f, 397.0f, 237.0f)];
//    [DAImageHelper changeImageBackgroundViewSize:imagePhotoBack imgView:canvasImageView
//                                           shift:kImageSize.origin.x - kImageBackgroundSize.origin.x
//                                          border:kImageBackgroundSize.size.width - kImageSize.size.width];
    
    // 画像のサイズを調整
    CGSize shrinkedSize = [DAHelper shrinkedImageSize:originalImage ownerView:self.imgRealImage];
    self.imgRealImage.image = [DAHelper resizeImage:originalImage frameSize:self.imgRealImage.frame.size imageSize:shrinkedSize];
    
    [UIView commitAnimations];
}


@end
