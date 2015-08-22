//
//  LongFormTableViewController.h
//
//  Copyright (c) 2015
//

#import <UIKit/UIKit.h>
#import "AcroViewController.h"
#import "AcromineHTTPClient.h"


@interface LongFormTableViewController : UITableViewController <AcronymUpdateDelegate, AcromineHTTPClientDelegate>

@property (copy, nonatomic) NSString *acronym;
@property (copy, nonatomic) NSArray *longForms;

@end
