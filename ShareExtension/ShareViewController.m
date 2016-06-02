//
//  ShareViewController.m
//  ShareExtension
//
//  Created by lieyunye on 16/6/1.
//  Copyright © 2016年 lieyunye. All rights reserved.
//

#import "ShareViewController.h"
#import "ConfigMenuTableViewController.h"

@interface ShareViewController ()
@property  SLComposeSheetConfigurationItem * item;
@property (strong, nonatomic) UINavigationBar *customNavBar;

@end

@implementation ShareViewController

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.customNavBar = [[UINavigationBar alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.customNavBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar removeFromSuperview];
    [self.navigationController.view addSubview:self.customNavBar];
    [self setCancelSaveNavigationItem];
}

-(void)setCancelSaveNavigationItem
{
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel",nil)  style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped:)];
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",nil)  style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
    newItem.leftBarButtonItem = cancelBarButtonItem;
    newItem.rightBarButtonItem = saveBarButtonItem;
    [self.customNavBar setItems:@[newItem]];
    [self.navigationItem setBackBarButtonItem:cancelBarButtonItem];
    [self.navigationItem setRightBarButtonItem:saveBarButtonItem];
    if(self.item.value == nil){
        saveBarButtonItem.enabled = NO;
    }
}

-(void)setBackNavigationItem
{
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *selectBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select",nil)  style:UIBarButtonItemStylePlain target:self action:@selector(selectButtonTapped:)];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"❮ %@", NSLocalizedString(@"Back",nil)]  style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped:)];
    newItem.leftBarButtonItem = backBarButtonItem;
    newItem.rightBarButtonItem = selectBarButtonItem;
    [self.customNavBar setItems:@[newItem]];
    [self.navigationItem setBackBarButtonItem:backBarButtonItem];
    [self.navigationItem setRightBarButtonItem:selectBarButtonItem];
}

- (void)backButtonTapped:(id)sender {
    if([self.navigationController.viewControllers count] ==2){
        [self setCancelSaveNavigationItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelButtonTapped:(id)sender {
    [self cancel];
}

- (void)selectButtonTapped:(id)sender {
    
    [self setCancelSaveNavigationItem];
    [self popConfigurationViewController];
}

- (void)saveButtonTapped:(id)sender {
    
    [self cancel];
}


- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    ConfigMenuTableViewController * configTable = [[ConfigMenuTableViewController alloc]init];
    configTable.size = self.preferredContentSize;
    self.item = [[SLComposeSheetConfigurationItem alloc]init];
    self.item.title = @"Option";
    __weak typeof(self) weakSelf = self;
    self.item.tapHandler = ^{ NSLog(@"block hit");
        [weakSelf setBackNavigationItem];
        [weakSelf pushConfigurationViewController:configTable];
    };

    return @[self.item];
}

@end
