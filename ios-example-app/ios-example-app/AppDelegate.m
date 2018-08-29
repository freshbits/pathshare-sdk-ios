//
//  AppDelegate.m
//  ios-example-app
//
//  Created by freshbits GmbH on 19.9.2015.
//  Copyright © 2017 freshbits GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import <PathshareSDK/PathshareSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initPathshare];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

- (void)initPathshare
{
    NSString *pathshare = [NSBundle.mainBundle pathForResource:@"Pathshare" ofType:@"plist"];
    NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:pathshare];

    [Pathshare setAccountToken:config[@"account_token"]];
    [Pathshare setTrackingMode:PSTrackingModeSmart];
}

@end
