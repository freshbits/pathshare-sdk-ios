# Pathshare SDK for iOS

![Pod Version](https://img.shields.io/cocoapods/v/PathshareSDK.svg?style=flat)
![Pod Platform](https://img.shields.io/badge/platform-ios-green.svg?style=flat)
![Language](https://img.shields.io/badge/language-objective--c-brightgreen.svg?style=flat)
![Language](https://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)

**Pathshare** is a realtime location sharing platform. For more information please visit the [Pathshare Developer Page](https://pathsha.re/professional/developers).

<img src="/assets/ios-example-app.png" height="600">

- [Requirements](#requirement)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
  - [Configuration](#configuration)
  - [Initialization](#initialization)
  - [Save Username](#save-username)
  - [Create Session](#create-session)
  - [Join Session](#join-session)
  - [Invite Customer](#invite-customer)
  - [Leave Session](#leave-session)
  - [Find Session](#find-session)


## Requirements

`PathshareSDK` for iOS supports iOS 11.x, 12.x, 13.x and 14.x.

## Installation

### Cocoapods

Add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'PathshareSDK', '~> 2.3'
```

Then install `PathshareSDK` into your project by executing the following code:

```ruby
pod install
```

### Manual Installation

The installation of the **Pathshare SDK** is simple. Please follow the following steps:

1. Drag and drop the `PathshareSDK.framework` you received upon registration into your project.
2. Add the `PathshareSDK.framework` to the *Embedded Binaries* in the *general* tab of your target.

## Basic Usage

### Configuration

In order to allow access to the location services and to use the location services in the background, please add the following configuration in your project:

1. Add the `NSLocationAlwaysUsageDescription`, the `NSMotionUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription` and the `NSLocationWhenInUseUsageDescription` keys with the corresponding descriptions to your `Info.plist` file.
2. If you are building against iOS 11.+, go to your `Project Target` > `Capabilities` > `Background Modes` and enable `Location updates`.

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
    [Pathshare setTrackingMode:PSTrackingModeSmart];
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
    let config = NSDictionary(contentsOfFile: pathshare) as NSDictionary!
    Pathshare.setAccountToken(config!.valueForKey("account_token") as! String)
    Pathshare.setTrackingMode(.smart)
}
```

Optionally, you can specify a tracking mode to configure the behavior of the location tracker. The following tracking modes are available:

Tracking Mode      | Description
-------------------|------------------------------------------------------------
`PSTrackingModeSmart`            | Adapts intelligently to the environment and usage of the device. Includes awareness of battery level, travel speed and motion activity.
`PSTrackingModeEco`              | Static mode providing constant tracking data with very low accuracy (several kilometers) and great distance between single locations and ensuring maximum battery life.
`PSTrackingModeApproximate`      | Static mode providing constant tracking data with low accuracy (several hundred meters) and middle distance between single locations. Useful when a low battery drain is a important criteria.
`PSTrackingModeAccurate`         | Static mode providing constant tracking with the highest accuracy possible (few meters) and small distances between locations. Useful for scenarios where a high accuracy is an essential requirement.

### Save User

Before creating a session, you need to set a username:

###### Objective-C
```Objective-c
[Pathshare saveUser:@"SDK User ios"
               type:UserTypeTechnician
              email:@"me@email.com"
              phone:@"+12345678901"
              image:[UIImage imageNamed:@"image"]
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
Pathshare.saveUser("SDK User",
                    type: .technician,
                    email: "me@email.com",
                    phone: "+12345678901",
                    image: UIImage.init(named: "image")) { (error: NSError!) -> Void in
    if error != nil {
        // ...
    } else {
        // ...
    }
}
```

The email address can be `nil`.

Use the same method `Pathshare.saveUser()` to create or update the user.

There are different types of users for specific industries:

User Types                  | Description
----------------------------|------------------------------------------------------------
`TECHNICIAN`, `MOTORIST`    | For roadside assitance industry or similar
`DRIVER`, `RECIPIENT`       | For delivery services or similar
`INVESTIGATOR`, `CLIENT`    | For legal services industry or similar

### Create Session

Use the session initializer to create a session:

###### Objective-C
```objective-c
Session *session = [[Session alloc] init];
session.expirationDate = expirationDate;
session.name = @"Shopping";
```

###### Swift
```swift
var session = Session()
session.expirationDate = expirationDate
session.name = "Shopping"
```

A session must have an expiration date and a name. You can create multiple sessions at the same time, the SDK will manage them for you.

Make sure to save the session after initializing:

###### Objective-C
```objective-c
[session save:^(NSError *error) { ... }];

session.identifier // => 3fd919fe824d8e7b78e2c11c1570a6f168d2c...
[session isExpired] // => false
[session URL] // => https://pathsha.re/6d39d5
```

###### Swift
```swift
session.save { (error: NSError!) -> Void in ... }

session.identifier // => 3fd919fe824d8e7b78e2c11c1570a6f168d2c...
session.isExpired() // => false
session.URL() // => https://pathsha.re/6d39d5
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
var session = Session()
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
var destination = Destination()
destination.identifier = "W2342"
destination.latitude = 47.378178
destination.longitude = 8.539256

var session = Session()
//...
session.destination = destination
```

### Join Session

To join the session you created, call the `join:` method on the session object:

###### Objective-C
```objective-c
[session join:^(NSError *error) { ... }];

[session isUserJoined] // => true
```

###### Swift
```swift
session.join { (error: NSError!) -> Void in ... }

session.isUserJoined() // => true
```

This call will add your Pathshare user to the session and you will be able to see his location in realtime on a map in the Pathshare Professional web interface.

### Invite customer

To invite a customer to the session, call the `inviteUser:` method on the session object:

###### Objective-C
```objective-c
[self.session inviteUserWithName:@"Customer"
                            type:UserTypeClient
                           email:@"customer@me.com"
                           phone:@"+12345678901"
               canSetDestination:YES
               completionHandler:^(NSURL *url, NSError *error) {
    if (error) {
        // ...
    } else {
        // ...
        NSLog(@"Invitation URL: %@", url.absoluteString);
    }
}];
```

###### Swift
```swift
session.inviteUser(withName: "Customer",
                    type: .client,
                    email: "customer@me.com",
                    phone: "+12345678901",
                    canSetDestination: true) { (url, error) in
    if error != nil {
        // ...
    } else {
        // ...
        NSLog("Invitation URL: \(String(describing: url?.absoluteString))")
    }
}
```

This call will create a customer user and return an invitation URL that can be sent to the customer using your preffered channel. The customer will then see the driver's location in realtime as well as the ETA in a white-labeled view with your corporate identity.

The customer will be able to enjoy the full realtime experience in the web browser of their smartphone:

<img src="/assets/web-view-customer.png" height="600">

### Leave Session

In order to stop sending user locations and remove the user from the session, call the `leave:` method:

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
                           session.delegate = self;
                           self.session = session;
                       }
                   }];
```

###### Swift
```swift
Pathshare.findSessionWithIdentifier("e2e422") { (session: Session!, error: NSError!) -> Void in
    if session != nil {
        session.delegate = self
        self.session = session
    }
}
```
