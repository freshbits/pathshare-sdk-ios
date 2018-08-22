//
//  ViewController.m
//  pathshare-sharing-sdk-demo-ios
//
//  Created by freshbits GmbH on 19.9.2015.
//  Copyright © 2015 freshbits GmbH. All rights reserved.
//

#import "ViewController.h"

static NSString *const kSessionIdentifierKey = @"session_id";

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *createButton;
@property (nonatomic, weak) IBOutlet UIButton *joinButton;
@property (nonatomic, weak) IBOutlet UIButton *inviteButton;
@property (nonatomic, weak) IBOutlet UIButton *leaveButton;
@property (nonatomic, strong) Session *session;
@end

@implementation ViewController
@synthesize session = _session;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initButtons];
    [self findSession];
}

- (void)initButtons
{
    if ([self hasActiveSession]) {
        self.createButton.enabled = NO;
        self.inviteButton.enabled = YES;
        self.leaveButton.enabled = YES;
    } else {
        self.createButton.enabled = YES;
        self.joinButton.enabled = NO;
        self.inviteButton.enabled = NO;
        self.leaveButton.enabled = NO;
    }
    
    self.createButton.layer.cornerRadius = 3.f;
    self.joinButton.layer.cornerRadius = 3.f;
    self.inviteButton.layer.cornerRadius = 3.f;
    self.leaveButton.layer.cornerRadius = 3.f;
}

#pragma mark - IBAction

- (IBAction)createSession:(id)sender
{
    [Pathshare saveUser:@"SDK User ios"
                   type:UserTypeTechnician
                  phone:@"+14159495533"
      completionHandler:^(NSError *error) {
              if (error) {
                  NSLog(@"User: Error");
                  NSLog(@"%@", error.description);
              } else {
                  NSLog(@"User: Success");
                  [self createSession];
              }
          }
     ];
}

- (IBAction)joinSession:(id)sender
{
    [self.session join:^(NSError *error) {
        if (error) {
            NSLog(@"Session Join: Error");
            NSLog(@"%@", error);
        } else {
            NSLog(@"Session Join: Success");
            self.createButton.enabled = NO;
            self.joinButton.enabled = NO;
            self.inviteButton.enabled = YES;
            self.leaveButton.enabled = YES;
        }
    }];
}

- (IBAction)inviteCustomer:(id)sender
{
    [self.session inviteUserWithName:@"Customer"
                                type:UserTypeClient
                               email:@"customer@me.com"
                               phone:@"12345678901"
                   completionHandler:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Invite Customer: Error");
            NSLog(@"%@", error);
        } else {
            NSLog(@"Invite Customer: Success");
            NSLog(@"Invitation URL: %@", url.absoluteString);
            self.inviteButton.enabled = NO;
            self.leaveButton.enabled = YES;
        }
    }];
}

- (IBAction)leaveSession:(id)sender
{
    [self.session leave:^(NSError *error) {
        if (error) {
            NSLog(@"Session Leave: Error");
            NSLog(@"%@", error);
        } else {
            NSLog(@"Session Leave: Success");
            self.leaveButton.enabled = NO;
            self.inviteButton.enabled = NO;
            self.createButton.enabled = YES;
            
            [self deleteSessionIdentifier];
        }
    }];
}

#pragma mark - private methods

- (void)createSession
{
    Destination *destination = [[Destination alloc] init];
    destination.identifier = @"store1234";
    destination.latitude = 37.7875694;
    destination.longitude = -122.4112239;
    
    self.session = [[Session alloc] init];
    self.session.name = @"Example Session ios";
    self.session.expirationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
    self.session.destination = destination;
    self.session.trackingMode = PSTrackingModeSmart;
    self.session.delegate = self;
    
    [self.session save:^(NSError *error) {
        if (error) {
            NSLog(@"Session: Error");
            NSLog(@"%@", error);
        } else {
            NSLog(@"Session: Success");
            self.joinButton.enabled = YES;
            self.createButton.enabled = NO;
            
            [self saveSessionIdentifier];
        }
    }];
}

- (void)findSession
{
    NSString *sessionID = [NSUserDefaults.standardUserDefaults objectForKey:kSessionIdentifierKey];
    
    if (!sessionID) { return; }
    
    [Pathshare findSessionWithIdentifier:sessionID
                       completionHandler:^(Session *session, NSError *error) {
                           if (session) {
                               session.delegate = self;
                               self.session = session;
                               
                               self.createButton.enabled = NO;
                               self.joinButton.enabled = YES;
                               self.inviteButton.enabled = NO;
                               self.leaveButton.enabled = NO;
                           }
                       }];
}

- (void)saveSessionIdentifier
{
    [NSUserDefaults.standardUserDefaults setObject:self.session.identifier forKey:kSessionIdentifierKey];
}

- (void)deleteSessionIdentifier
{
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kSessionIdentifierKey];
}

- (BOOL)hasActiveSession
{
    return self.session.isSaved && !self.session.isExpired;
}

#pragma mark - SessionExpirationDelegate methods

- (void)sessionDidExpire
{
    [self deleteSessionIdentifier];
    
    self.leaveButton.enabled = NO;
    self.joinButton.enabled = NO;
    self.inviteButton.enabled = NO;
    self.createButton.enabled = YES;
}

@end
