//
//  AppDelegate.m
//
//  Copyright (c) 2015
//

#import "AcromineHTTPClient.h"
#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.acromineHTTPClient = [[AcromineHTTPClient alloc] init];
    
    return YES;
}

@end
