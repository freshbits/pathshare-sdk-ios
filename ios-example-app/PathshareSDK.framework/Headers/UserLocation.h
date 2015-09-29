
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class MotionActivity;

@interface UserLocation : NSObject
@property (nonatomic, strong) CLLocation *clLocation;
@property (nonatomic, readonly) CLLocationDegrees latitude;
@property (nonatomic, readonly) CLLocationDegrees longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CLLocationAccuracy horizontalAccuracy;
@property (nonatomic, readonly) CLLocationDirection course;
@property (nonatomic, readonly) CLLocationSpeed speed;
@property (nonatomic, readonly) NSTimeInterval recordedAt;
@property (nonatomic, strong) MotionActivity *motionActivity;
@property (nonatomic, strong) NSString *accuracyMode;
@property (nonatomic) int batteryLevelPercentage;
- (id)initWithCLLocation:(CLLocation *)userLocation;
- (NSDictionary *)asJSON;
- (NSTimeInterval)timeIntervalSinceNow;
- (BOOL)isValid;
- (BOOL)isRelevant;
@end
