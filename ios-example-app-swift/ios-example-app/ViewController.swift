//
//  ViewController.swift
//  ios-example-app
//
//  Created by freshbits GmbH on 30.9.2015.
//  Copyright © 2017 freshbits GmbH. All rights reserved.
//

import UIKit
import PathshareSDK

class ViewController: UIViewController, SessionExpirationDelegate {
    
    let sessionIdentifierKey = "session_id"
    var session: Session!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
        findSession()
    }
    
    fileprivate func initButtons() {
        self.createButton.layer.cornerRadius = 3.0
        self.joinButton.layer.cornerRadius = 3.0
        self.inviteButton.layer.cornerRadius = 3.0
        self.leaveButton.layer.cornerRadius = 3.0
        
        self.createButton.isEnabled = true
        self.joinButton.isEnabled = false
        self.inviteButton.isEnabled = false
        self.leaveButton.isEnabled = false
    }

    // MARK: IBActions
    
    @IBAction func createSession(_ sender: AnyObject) {
        Pathshare.saveUser("SDK User", type: .technician, phone: "+12345678901") { (error) -> Void in
            if error != nil {
                NSLog("User: Error")
                NSLog(error!.localizedDescription)
            } else {
                NSLog("User: Success")
                self.createSession()
            }
        }
    }
    
    @IBAction func joinSession(_ sender: AnyObject) {
        self.session.join { (error) -> Void in
            if error != nil {
                NSLog("Session Join: Error")
                NSLog(error!.localizedDescription)
            } else {
                NSLog("Session Join: Success")
                self.createButton.isEnabled = false
                self.joinButton.isEnabled = false
                self.inviteButton.isEnabled = true
                self.leaveButton.isEnabled = true
            }
        }
    }
    
    @IBAction func inviteCustomer(_ sender: AnyObject) {
        self.session.inviteUser(withName: "Customer", type: .client, email: "customer@me.com", phone: "+12345678901") { (url, error) in
            if error != nil {
                NSLog("Invite Customer: Error")
                NSLog(error!.localizedDescription)
            } else {
                NSLog("Invite Customer: Success")
                NSLog("Invitation URL: \(String(describing: url!.absoluteString))")
                self.inviteButton.isEnabled = false
                self.leaveButton.isEnabled = true
            }
        }
    }
    
    @IBAction func leaveSession(_ sender: AnyObject) {
        self.session.leave { (error) -> Void in
            if error != nil {
                NSLog("Session Leave: Error")
                NSLog(error!.localizedDescription)
            } else {
                NSLog("Session Leave: Success")
                self.createButton.isEnabled = true
                self.joinButton.isEnabled = false
                self.inviteButton.isEnabled = false
                self.leaveButton.isEnabled = false
                
                self.deleteSessionIdentifier()
            }
        }
    }
    
    fileprivate func createSession() {
        let destination = Destination()
        destination.identifier = "store1234"
        destination.latitude = 47.378178
        destination.longitude = 8.539256
        
        self.session = Session()
        self.session.name = "Example Session ios"
        self.session.expirationDate = Date(timeIntervalSinceNow: 3600)
        self.session.destination = destination
        self.session.delegate = self
        
        self.session.save { (error) -> Void in
            if error != nil {
                NSLog("Session: Error")
                NSLog(error!.localizedDescription)
            } else {
                NSLog("Session: Success")
                self.joinButton.isEnabled = true
                self.createButton.isEnabled = false
                self.leaveButton.isEnabled = true
                
                self.saveSessionIdentifier()
            }
        }
    }
    
    fileprivate func findSession() {
        let sessionIdentifier = UserDefaults.standard.object(forKey: sessionIdentifierKey) as? String
        
        guard sessionIdentifier != nil else { return }
        
        Pathshare.findSession(withIdentifier: sessionIdentifier) { (session, error) -> Void in
            if session != nil && !(session?.isExpired())! {
                session?.delegate = self
                self.session = session
                
                self.createButton.isEnabled = false
                self.joinButton.isEnabled = true
                self.inviteButton.isEnabled = false
                self.leaveButton.isEnabled = true
            } else {
                self.createButton.isEnabled = true
                self.joinButton.isEnabled = false
                self.inviteButton.isEnabled = false
                self.leaveButton.isEnabled = false
            }
        }
    }
    
    fileprivate func saveSessionIdentifier() {
        UserDefaults.standard.set(self.session.identifier, forKey: sessionIdentifierKey)
    }
    
    fileprivate func deleteSessionIdentifier() {
        UserDefaults.standard.removeObject(forKey: sessionIdentifierKey)
    }
    
    // MARK: SessionExpirationDelegate
    
    func sessionDidExpire() {
        deleteSessionIdentifier()
        
        self.leaveButton.isEnabled = false
        self.joinButton.isEnabled = false
        self.inviteButton.isEnabled = false
        self.createButton.isEnabled = true
    }
}
