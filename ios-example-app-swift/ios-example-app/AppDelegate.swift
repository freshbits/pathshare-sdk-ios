//
//  AppDelegate.swift
//  ios-example-app
//
//  Created by freshbits GmbH on 30.9.2015.
//  Copyright © 2015 freshbits GmbH. All rights reserved.
//

import UIKit
import PathshareSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        initPathshare()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {}
    
    private func initPathshare() {
        let pathshare = NSBundle.mainBundle().pathForResource("Pathshare", ofType:"plist") as String!
        let config = NSDictionary(contentsOfFile: pathshare) as NSDictionary!
        Pathshare.setAccountToken(config!.valueForKey("account_token") as! String)
    }

}

