//
//  UserType.h
//  PathshareSDK
//
//  Created by freshbits on 21.8.2018.
//  Copyright © 2018 freshbits GmbH. All rights reserved.
//

/*!
 * @discussion Specifies the user type.
 * @since Available in 2.0.0 and later.
 */
typedef NS_ENUM(NSInteger, UserType) {
    UserTypeTechnician,
    UserTypeMotorist,
    UserTypeDriver,
    UserTypeRecipient,
    UserTypeInvestigator,
    UserTypeClient
};

extern NSString * NSStringForUserType(UserType type);
extern UserType UserTypeForNSString(NSString * typeString);
