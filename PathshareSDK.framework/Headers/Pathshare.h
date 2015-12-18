//
// PathshareSDK.h
// PathshareSDK
//
//  Created by freshbits GmbH on 17.8.2015.
//  Copyright (c) 2015 freshbits GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
 * @param completionHandler The block to be returned, if successfull.
 * @since Available in 1.0 and later.
 */
+ (void)saveUserName:(NSString *)name completionHandler:(void(^)(NSError *error))completionHandler;

@end
