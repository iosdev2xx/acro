//
//  AppDelegate.h
//
//  Copyright (c) 2015
//

#import <UIKit/UIKit.h>


@class AcromineHTTPClient;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) AcromineHTTPClient *acromineHTTPClient;
@property (strong, nonatomic) UIWindow *window;

@end

