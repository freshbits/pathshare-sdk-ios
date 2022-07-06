//
//  TrackingMode.h
// PathshareSDK
//
//  Created by freshbits GmbH on 27.9.2015.
//  Copyright © 2015 freshbits GmbH. All rights reserved.
//

/*!
 * @discussion Specifies the tracking mode and location delivery methods of the location tracker.
 * @since Available in 1.0 and later.
 */
typedef NS_ENUM(NSInteger, PSTrackingMode) {
    PSTrackingModeApproximate,
    PSTrackingModeEco,
    PSTrackingModeAccurate,
    PSTrackingModeSmart
};
