//
//  PathshareSDK.h
//  PathshareSDK
//
//  Created by freshbits GmbH on 17.8.2015.
//  Copyright (c) 2015 freshbits GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0_0
#error This version (2.0.0) of Pathshare Location Pathshare SDK for iOS supports iOS 10.0 upwards.
#endif

//! Project version number forPathshareSDK.
FOUNDATION_EXPORT double PathshareSDKVersionNumber;

//! Project version string forPathshareSDK.
FOUNDATION_EXPORT const unsigned charPathshareSDKVersionString[];

#import <PathshareSDK/Pathshare.h>
#import <PathshareSDK/Session.h>
#import <PathshareSDK/Destination.h>
#import <PathshareSDK/PSTrackingMode.h>
#import <PathshareSDK/UserType.h>
