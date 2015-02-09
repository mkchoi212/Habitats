
//
//  AppDelegate.swift
//  AuctionApp
//
//  Created by Mike Choi on 17/11/2014.
//  Copyright (c) 2014 LifePlusDev. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //LOCAL NOTIFICATION
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert |
            UIUserNotificationType.Badge, categories: nil))

        
        Parse.setApplicationId("VWIeWYGctZOVxF1RmaCiKkR9RmUZJL0pIwjeyvcg", clientKey: "UDqmMz1SkzVQnDixF6uDIIb1C5Q0142OSJLxpkSv")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        

        
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            let itemVC = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateInitialViewController() as? UINavigationController
            window?.rootViewController=itemVC
        } else {
            //Prompt User to Login
            let loginVC = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("LoginViewController") as LoginViewController
            window?.rootViewController=loginVC
        }
        
        UITextField.appearance().tintColor = UIColor.whiteColor()
        
        
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 82/255, green: 17/255, blue: 14/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UISearchBar.appearance().barTintColor = UIColor(red: 82/255, green: 17/255, blue: 14/255, alpha: 1.0)
        
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstalation = PFInstallation.currentInstallation()
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for var i = 0; i < deviceToken.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        println("tokenString: \(tokenString)")
        
        currentInstalation.setDeviceTokenFromData(deviceToken)
        currentInstalation.saveInBackgroundWithBlock(nil)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        NSNotificationCenter.defaultCenter().postNotificationName("pushRecieved", object: userInfo)
        
    }
    
    
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = "Come back and check out some items!"
        
        localNotification.fireDate = NSDate(timeIntervalSinceNow:600000)
        localNotification.repeatInterval = NSCalendarUnit.CalendarUnitMonth
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge, categories: nil))
        }
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    application.applicationIconBadgeNumber = 0
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
}



