# Pathshare SDK for iOS

**Pathshare** is a realtime location sharing platform. For more information please visit the [Pathshare Developer Page](https://pathsha.re/developers).

- [Requirements](#requirement)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
  - [Initialize Pathshare](#init-pathshare)
  - [Save Username](#save-username)
  - [Create Session](#create-session)
  - [Join Session](#join-session)
  - [Leave Session](#leave-session)
  - [Find Session](#find-session)


## Requirements

PathshareSDK for iOS supports iOS 8.x and iOS 9.x.

## Installation

The installation of the **Pathshare SDK** is simple. Please follow the following steps:

1. Drag and drop the `PathshareSDK.framework` you received upon registration into your project.
2. Add the `PathshareSDK.framework` to the *Embedded Binaries* in the *general* tab of your target.
3. Add the `NSLocationAlwaysUsageDescription` and the `NSMotionUsageDescription` keys with the corresponding descriptions to your `Info.plist` file.

## Basic Usage

### Initialization

In order to initialize the Pathshare SDK, create a file named `pathshare.plist` inside your project and add your account token:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>account_token</key>
    <string>your PathshareSDK account token</string>
</dict>
</plist>

```

Next, add the following to the `application:didFinishLaunchingWithOptions:` method of your `AppDelegate` class:

###### Objective-C
```Objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initPathshare];
    return YES;
}

...

- (void)initPathshare
{
    NSString *pathshare = [NSBundle.mainBundle pathForResource:@"pathshare" ofType:@"plist"];
    NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:pathshare];

    [Pathshare setAccountToken:config[@"account_token"]];
}
```
###### Swift
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    initPathshare()
    return true
}

...

private func initPathshare() {
    let pathshare = NSBundle.mainBundle().pathForResource("Pathshare", ofType:"plist") as String!
    let config = NSDictionary.init(contentsOfFile: pathshare) as NSDictionary!
    Pathshare.setAccountToken(config!.valueForKey("account_token") as! String)
}
```

### Save Username

Before creating a session, you need to set a username:

###### Objective-C
```Objective-c
[Pathshare saveUserName:@"Candice"
      completionHandler:^(NSError *error) {
          if (error) {
              // ...
          } else {
              // ...
          }
      }
 ];
```

###### Swift
```swift
Pathshare.saveUserName("SDK User ios") { (error: NSError!) -> Void in
    if error != nil {
        // ...
    } else {
        // ...
    }
}
```
### Create Session

Use the session initializer to create a session:

###### Objective-C
```objective-c
Session *session = [[Session alloc] init];
session.expirationDate = expirationDate;
session.name = @"Shopping";
session.trackingMode = PSTrackingModeSmart;
```

###### Swift
```swift
var session = Session.init()
session.expirationDate = expirationDate
session.name = "Shopping"
session.trackingMode = PSTrackingMode.Smart
```

A session must have an expiration date and a name. Optionally, you can specify a tracking mode to configure the behavior of the location tracker. The following tracking modes are available:

Tracking Mode      | Description
-------------------|------------------------------------------------------------
`PSTrackingModeSmart`            | Adapts intelligently to the environment and usage of the device. Includes awareness of battery level, travel speed and motion activity.
`PSTrackingModeEco`              | Static mode providing constant tracking data with very low accuracy (several kilometers) and great distance between single locations and ensuring maximum battery life.
`PSTrackingModeApproximate`      | Static mode providing constant tracking data with low accuracy (several hundred meters) and middle distance between single locations. Useful when a low battery drain is a important criteria.
`PSTrackingModeAccurate`         | Static mode providing constant tracking with the highest accuracy possible (few meters) and small distances between locations. Useful for scenarios where a high accuracy is an essential requirement.

Make sure to save the session after initializing:

###### Objective-C
```objective-c
[session save:^(NSError *error) { ... }];

session.identifier // => 3fd919fe824d8e7b78e2c11c1570a6f168d2c...
[session isExpired] // => false
```

###### Swift
```swift
session.save { (error: NSError!) -> Void in ... }

session.identifier // => 3fd919fe824d8e7b78e2c11c1570a6f168d2c...
session.isExpired() // => false
```

#### Expiration

In order to react to the expiration of the session, implement the `SessionExpirationDelegate` protocol in your class:

###### Objective-C
```objective-c
@interface ViewController : UIViewController <SessionExpirationDelegate>
    // ...
@end
```

###### Swift
```swift
class ViewController: UIViewController, SessionExpirationDelegate { ... }
```

Then set the `delegate` on your session instance:

###### Objective-C
```objective-c
Session *session = [[Session alloc] init];
session.delegate = self;
```

###### Swift
```swift
var session = Session.init()
session.delegate = self
```

Finally, implement the `sessionDidExpire` method in your class to react to the expiration event:

###### Objective-C
```objective-c
- (void)sessionDidExpire { ... }
```

###### Swift
```swift
func sessionDidExpire() { ... }
```

#### Destination

Optionally, you can add a destination to the session. Sessions with destination will show the estimated time of arrival (ETA) for each user. The destination identifier is used to group sessions by destination.

###### Objective-C
```objective-c
Destination *destination = [[Destination alloc] init];
destination.identifier = @"W2342";
destination.latitude = 47.378178;
destination.longitude = 8.539256;

Session *session = [[Session alloc] init];
//...
session.destination = destination;
```

###### Swift
```swift
var destination = Destination.init()
destination.identifier = "W2342"
destination.latitude = 47.378178
destination.longitude = 8.539256

var session = Session.init()
//...
session.destination = destination
```

### Join Session

To join the session you created, call the `joinUser:` method on the session object:

###### Objective-C
```objective-c
[session joinUser:^(NSError *error) { ... }];

[session isUserJoined] // => true
```

###### Swift
```swift
session.joinUser { (error: NSError!) -> Void in ... }

session.isUserJoined() // => true
```

This call will add your Pathshare user to the session and you will be able to see his location in realtime on a map in the Pathshare Professional web interface.

### Leave Session

In order to stop sending user locations and remove the user from the session, call the `leaveUser:` method:

###### Objective-C
```objective-c
[session leaveUser:^(NSError *error) { ... }];
```

###### Swift
```swift
session.leaveUser { (error: NSError!) -> Void in ... }
```

### Find Session

To find an existing session, use the `findSessionWithIdentifier:completionHandler:` method with the corresponding session identifier:

###### Objective-C
```objective-c
[Pathshare findSessionWithIdentifier:@"e2e422"
                   completionHandler:^(Session *session, NSError *error) {
                       if (session) {
                           self.session = session;
                       }
                   }];
```

###### Swift
```swift
Pathshare.findSessionWithIdentifier("e2e422") { (session: Session!, error: NSError!) -> Void in
    if session != nil {
        self.session = session
    }
}
```