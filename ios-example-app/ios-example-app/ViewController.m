//
//  ViewController.m
//  ios-example-app
//
//  Created by freshbits GmbH on 19.9.2015.
//  Copyright © 2017 freshbits GmbH. All rights reserved.
//

#import "ViewController.h"

static NSString *const kSessionIdentifierKey = @"session_id";

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *createButton;
@property (nonatomic, weak) IBOutlet UIButton *joinButton;
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
    self.joinButton.enabled = NO;
    self.leaveButton.enabled = NO;
}

#pragma mark - IBAction

- (IBAction)createSession:(id)sender
{
    [Pathshare saveUserName:@"SDK User iOS"
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
    [self.session joinUser:^(NSError *error) {
        if (error) {
            NSLog(@"Session Join: Error");
            NSLog(@"%@", error.description);
        } else {
            NSLog(@"Session Join: Success");
            self.createButton.enabled = NO;
            self.joinButton.enabled = NO;
            self.leaveButton.enabled = YES;
        }
    }];
}

- (IBAction)leaveSession:(id)sender
{
    [self.session leaveUser:^(NSError *error) {
        if (error) {
            NSLog(@"Session Leave: Error");
            NSLog(@"%@", error.description);
        } else {
            NSLog(@"Session Leave: Success");
            self.leaveButton.enabled = NO;
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
    destination.latitude = 47.378178;
    destination.longitude = 8.539256;

    self.session = [[Session alloc] init];
    self.session.name = @"Example Session ios";
    self.session.expirationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3600];
    self.session.destination = destination;
    self.session.trackingMode = PSTrackingModeSmart;
    self.session.delegate = self;

    [self.session save:^(NSError *error) {
        if (error) {
            NSLog(@"Session: Error");
            NSLog(@"%@", error.description);
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
    NSString *sessionIdentifier = [NSUserDefaults.standardUserDefaults objectForKey:kSessionIdentifierKey];
    
    if (!sessionIdentifier) { return; }
    
    [Pathshare findSessionWithIdentifier:sessionIdentifier
                       completionHandler:^(Session *session, NSError *error) {
                           if (session) {
                               session.delegate = self;
                               self.session = session;
                               
                               self.createButton.enabled = NO;
                               self.joinButton.enabled = YES;
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

#pragma mark - SessionExpirationDelegate

- (void)sessionDidExpire
{
    self.leaveButton.enabled = NO;
    self.joinButton.enabled = NO;
    self.createButton.enabled = YES;
}

@end
