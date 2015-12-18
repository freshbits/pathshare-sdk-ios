//
// PathshareSDK.h
// PathshareSDK
//
//  Created by freshbits GmbH on 17.8.2015.
//  Copyright (c) 2015 freshbits GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSTrackingMode.h"
@class Destination;

/*!
 * @brief The SessionExpirationDelegate protocol defines a set of optional methods that you can use to receive.
 * session-related update messages.
 * @since Available in 1.0 and later.
 */
@protocol SessionExpirationDelegate<NSObject>
@optional
/*!
 * @brief Tells the delegate that the session has expired.
 * @since Available in 1.0 and later.
 */
- (void)sessionDidExpire;
@end

/*!
 * @discussion The Session class represents a timely restricted entity that allows to send a users location to a server.
 * @since Available in 1.0 and later.
 */
@interface Session : NSObject

/*!
 * @brief The identification string for the session.
 * @discussion Each session has a unique identifier that allows the session to be queried.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, strong) NSString *identifier;

/*!
 * @brief The name of the session.
 * @discussion Represents the session title.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, strong) NSString *name;

/*!
 * @brief The expiration date of the session.
 * @discussion The date at which the session will be invalidated.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, strong) NSDate *expirationDate;

/*!
 * @brief The destination of the session.
 * @discussion The destionation represents the geo location where the user is heading to.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, strong) Destination *destination;

/*!
 * @brief The tracking mode.
 * @discussion The tracking mode corresponds to the gps tracker setting.
 * @since Available in 1.0 and later.
 */
@property (nonatomic) PSTrackingMode trackingMode;

/*!
 * @brief The session expiration delegate.
 * @discussion In case a session expires, the delegate of the session will get notified using the corresponding method.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, weak) id<SessionExpirationDelegate> delegate;

/*!
 * @brief Find a session using the given identifier.
 * @param identifier The session identifier.
 * @param completionHandler The block to be returned, if successful.
 * @since Available in 1.0 and later.
 */
+ (void)findWithIdentifier:(NSString *)identifier
         completionHandler:(void(^)(Session *session, NSError *error))completionHandler;

/*!
 * @brief Remotely saves the session.
 * @param completionHandler The block to be returned, if successful.
 * @since Available in 1.0 and later.
 */
- (void)save:(void(^)(NSError *error))completionHandler;

/*!
 * @brief Checks, if the session has been properly saved.
 * @return YES, if is saved, NO otherwise.
 * @since Available in 1.0 and later.
 */
- (BOOL)isSaved;

/*!
 * @brief Remotely joins the Pathshare user to the session.
 * @param completionHandler The block to be returned, if successful.
 * @since Available in 1.0 and later.
 */
- (void)joinUser:(void(^)(NSError *error))completionHandler;

/*!
 * @brief Checks, if user has successfully joined.
 * @return YES, if user has joined, NO otherwise.
 * @since Available in 1.0 and later.
 */
- (BOOL)isUserJoined;

/*!
 * @brief Remotely leaves the user from the session.
 * @param completionHandler The block to be returned, if successful.
 * @since Available in 1.0 and later.
 */
- (void)leaveUser:(void(^)(NSError *error))completionHandler;

/*!
 * @brief Checks, whether the session is expired.
 * @return YES, if is expired, NO otherwise.
 * @since Available in 1.0 and later.
 */
- (BOOL)isExpired;

/*!
 * @brief Returns the session URL.
 * @return The session URL.
 * @since Available in 1.0 and later.
 */
- (NSString *)URL;

@end
