//
//  ViewController.swift
//  ios-example-app
//
//  Created by freshbits GmbH on 30.9.2015.
//  Copyright © 2015 freshbits GmbH. All rights reserved.
//

import UIKit
import PathshareSDK

class ViewController: UIViewController, SessionExpirationDelegate {
    
    @IBOutlet weak var createButton: UIButton?
    @IBOutlet weak var joinButton: UIButton?
    @IBOutlet weak var leaveButton: UIButton?
    
    let session = Session.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
    }
    
    private func initButtons() {
        self.joinButton?.enabled = false
        self.leaveButton?.enabled = false
    }

    // MARK: IBActions
    
    @IBAction func createSession(sender: AnyObject) {
        Pathshare.saveUserName("SDK User ios") { (error: NSError!) -> Void in
            if error != nil {
                NSLog("User: Error")
                NSLog(error.description)
            } else {
                NSLog("User: Success")
                self.createSession()
            }
        }
    }
    
    @IBAction func joinSession(sender: AnyObject) {
        self.session.joinUser { (error: NSError!) -> Void in
            if error != nil {
                NSLog("Session Join: Error")
                NSLog(error.description)
            } else {
                NSLog("Session Join: Success")
                self.createButton?.enabled = false
                self.joinButton?.enabled = false
                self.leaveButton?.enabled = true
            }
        }
    }
    
    @IBAction func leaveSesson(sender: AnyObject) {
        self.session.leaveUser { (error: NSError!) -> Void in
            if error != nil {
                NSLog("Session Leave: Error")
                NSLog(error.description)
            } else {
                NSLog("Session Leave: Success")
                self.leaveButton?.enabled = false
                self.createButton?.enabled = true
            }
        }
    }
    
    private func createSession() {
        let destination = Destination.init()
        destination.identifier = "store1234"
        destination.latitude = 47.378178
        destination.longitude = 8.539256
        
        self.session.name = "Example Session ios"
        self.session.expirationDate = NSDate.init(timeIntervalSinceNow: 3600)
        self.session.destination = destination
        self.session.trackingMode = PSTrackingMode.Smart
        self.session.delegate = self
        
        self.session.save { (error: NSError!) -> Void in
            if error != nil {
                NSLog("Session: Error")
                NSLog(error.description)
            } else {
                NSLog("Session: Success")
                self.joinButton?.enabled = true
                self.createButton?.enabled = false
            }
        }
    }
    
    // MARK: SessionExpirationDelegate
    
    func sessionDidExpire() {
        self.leaveButton?.enabled = false
        self.joinButton?.enabled = false
        self.createButton?.enabled = true
    }
}

