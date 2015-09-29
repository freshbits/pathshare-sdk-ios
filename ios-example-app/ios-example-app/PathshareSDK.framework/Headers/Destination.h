//
//  Destination.h
// PathshareSDK
//
//  Created by freshbits GmbH on 18.8.2015.
//  Copyright (c) 2015 freshbits GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*!
 * @discussion The destination class represents the target geo location of a session that the user is moving towards.
 * @since Available in 1.0 and later.
 */
@interface Destination : NSObject

/*!
 * @brief The destination identifier.
 * @discussion If the destination is e.g. a store, the identifier would correspond to the store name or some other kind
 * of internal identification.
 * @since Available in 1.0 and later.
 */
@property (nonatomic, strong) NSString *identifier;

/*!
 * @brief The latitude of the geo location.
 * @since Available in 1.0 and later.
 */
@property (nonatomic) CLLocationDegrees latitude;

/*!
 * @brief The longitude of the geo location.
 * @since Available in 1.0 and later.
 */
@property (nonatomic) CLLocationDegrees longitude;

/*!
 * @brief Creates a new destination with the given identifier.
 * @param identifier The session identifier.
 * @param latitude The latitude of the geo location.
 * @param longitude The longitude of the geo location.
 * @since Available in 1.0 and later.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                          latitude:(CLLocationDegrees)latitude
                         longitude:(CLLocationDegrees)longitude;

@end
