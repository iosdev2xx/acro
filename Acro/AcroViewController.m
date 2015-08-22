//
//  AcroViewController.m
//  Acro
//
//  Copyright (c) 2015
//

#import "AppDelegate.h"
#import "AcroViewController.h"
#import "LongFormTableViewController.h"


@implementation AcroViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.inputTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.inputTextField becomeFirstResponder];
}

#pragma mark - IBAction

- (IBAction)lookupAction:(id)sender {
    if (self.inputTextField.isFirstResponder) {
        [self.inputTextField resignFirstResponder];
    }
    
//    if ([self.inputText isEqualToString:self.inputTextField.text]) {
//        return;
//    }
//    
    self.inputText = self.inputTextField.text;
    if (self.inputText.length > 1) {
        [self.delegate acronymDidChange:self.inputText];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    // Invalidate existing results
    [self.delegate acronymDidChange:nil];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Invalidate existing results
    [self.delegate acronymDidChange:nil];

    NSCharacterSet  *characterSet= [[NSCharacterSet uppercaseLetterCharacterSet] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];

    return [string isEqualToString:filtered];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self lookupAction:textField];
    
    return YES;
}

#pragma mark - Storyboard navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmbedLongForm"]) {
        LongFormTableViewController *childViewControler = (LongFormTableViewController *)segue.destinationViewController;
        self.delegate = childViewControler;
    }
}

@end
