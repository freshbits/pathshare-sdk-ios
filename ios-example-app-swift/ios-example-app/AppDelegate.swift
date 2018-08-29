//
//  AppDelegate.swift
//  ios-example-app
//
//  Created by freshbits GmbH on 30.9.2015.
//  Copyright © 2017 freshbits GmbH. All rights reserved.
//

import UIKit
import PathshareSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initPathshare()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    fileprivate func initPathshare() {
        let pathshare = Bundle.main.path(forResource: "Pathshare", ofType:"plist") as String?
        let config = NSDictionary(contentsOfFile: pathshare!) as NSDictionary?
        Pathshare.setAccountToken(config!.value(forKey: "account_token") as! String)
        Pathshare.setTrackingMode(.smart)
    }

}

