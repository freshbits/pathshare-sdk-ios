//
// PathshareSDK.h
// PathshareSDK
//
//  Created by freshbits GmbH on 17.8.2015.
//  Copyright (c) 2015 freshbits GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserType.h"
#import "PSTrackingMode.h"
@class Session;

/*!
 * @discussion Pathshare class represents the PathareSDK. Use this class in order to use thePathshareSDK.
 * @since Available in 1.0 and later.
 */
@interface Pathshare : NSObject

/*!
 * @brief Sets the account token needed to use the PathareSDK.
 * @discussion Initialize PathshareSDK with your iOS account token. This will allow your app to connect with PathshareSDK. This is best done in the application delegate's didFinishLaunchingWithOptions: method.
 * @param token The account token to use the PathshareSDK.
 * @since Available in 1.0 and later.
 */
+ (void)setAccountToken:(NSString *)token;

/*!
 * @brief The tracking mode.
 * @discussion The tracking mode corresponds to the gps tracker setting.
 * @since Available in 2.1 and later.
 */
+ (void)setTrackingMode:(PSTrackingMode)trackingMode;

/*!
 * @brief Returns a session object with the given identifier if it already exists, nil otherwise.
 * @param identifier A unique identifier for the session.
 * @param completionHandler The block to be returned, if successful.
 * @return The Session instance with the given identifier.
 * @since Available in 1.0 and later.
 */
+ (void)findSessionWithIdentifier:(NSString *)identifier
                completionHandler:(void(^)(Session *session, NSError *error))completionHandler;

/*!
 * @brief Set the user name.
 * @param name A user name used to identify the user.
 * @param type A user type to specify the user.
 * @param phone A user's email.
 * @param phone A user's phone.
 * @param completionHandler The block to be returned, if successfull.
 * @since Available in 2.0 and later.
 */
+ (void)saveUser:(NSString *)name
            type:(UserType)type
           email:(NSString *)email
           phone:(NSString *)phone
completionHandler:(void(^)(NSError *error))completionHandler;

@end
