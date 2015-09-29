
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionActivity : NSObject

@property (nonatomic, strong) NSString *name;
- (instancetype)initWithActivity:(CMMotionActivity *)activity;
- (instancetype)initWithActivityType:(NSString *)type;
@end
