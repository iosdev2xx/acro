//
//  LongFormTableViewController.m
//
//  Copyright (c) 2015
//

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "LongFormTableViewController.h"


@implementation LongFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AcromineHTTPClient *acromineHTTPClient = appDelegate.acromineHTTPClient;
    acromineHTTPClient.delegate = self;
}

#pragma mark - LongFormUpdateDelegate

- (void)acronymDidChange:(NSString *)acronym {
    if ([self.acronym isEqualToString:acronym] && self.longForms) {
        
        return;
    }
    
    self.acronym = acronym;
    
    self.longForms = nil;
    [self.tableView reloadData];

    if (acronym.length > 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading...";
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.acromineHTTPClient fetchLongFormsForAcronym:self.acronym];
    }
}

#pragma mark - AcromineHTTPClientDelegate

- (void)acromineHTTPClient:(AcromineHTTPClient *)client didFetchLongForms:(id)longForms {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = YES;
    
    if (((NSArray *)longForms).count) {
        self.longForms = longForms[0][@"lfs"];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];

        hud.labelText = [NSString stringWithFormat:@"%ld results", (unsigned long)self.longForms.count];
    } else {
        hud.labelText = @"No results";
    }
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [hud hide:YES];
    });
}

- (void)acromineHTTPClient:(AcromineHTTPClient *)client didFailFetchingLongFormsWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        [self showOKAlertWithTitle:@"Network Unavailable" message:nil];
        
        return;
    }

    [self showOKAlertWithTitle:@"Error Retrieving Long Forms" message:[NSString stringWithFormat:@"%@",error.localizedDescription]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.longForms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LongFormCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.longForms[indexPath.row][@"lf"];
    
    return cell;
}

#pragma mark - Private methods

- (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
