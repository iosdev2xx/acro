//
//  AcroViewController.h
//
//  Copyright (c) 2015
//

#import <UIKit/UIKit.h>


@protocol AcronymUpdateDelegate <NSObject>

- (void)acronymDidChange:(NSString *)acronym;

@end


@interface AcroViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *lookupButton;

@property (copy, nonatomic) NSString *inputText;
@property (weak, nonatomic) id<AcronymUpdateDelegate> delegate;

@end
