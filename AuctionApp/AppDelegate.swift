
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
        
        //ICETUTORIAL
        // Init the pages texts, and pictures.
        var layer1: ICETutorialPage = ICETutorialPage(title: "Hello", subTitle: "Welcome to Habitats", pictureName: "logopic", duration: 3.0)
        var layer2: ICETutorialPage = ICETutorialPage(title: "Auctions", subTitle: "Bid on your favorite shack", pictureName: "shacks", duration: 3.0)
        var layer3: ICETutorialPage = ICETutorialPage(title: "Experience", subTitle: "Get an experience of your lifetime through the event Shackathon", pictureName: "comeshack", duration: 3.0)
        var layer4: ICETutorialPage = ICETutorialPage(title: "Community", subTitle: "Embrace the sense of community through various events hosted by Habitat", pictureName: "grouppic", duration: 3.0)
        var layer5: ICETutorialPage = ICETutorialPage(title: "Enjoy", subTitle: "Thanks for coming and happy bidding", pictureName: "love", duration: 3.0)
    
        // Set the common style for SubTitles and Description (can be overrided on each page).
        var titleStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        titleStyle.font = UIFont(name: "Helvetica-Bold", size: 17.0)
        titleStyle.color = UIColor.whiteColor()
        titleStyle.linesNumber = 1
        titleStyle.offsset = 180
        
        var subStyle: ICETutorialLabelStyle = ICETutorialLabelStyle()
        subStyle.font = UIFont(name: "Helvetica", size: 15.0)
        subStyle.color = UIColor.whiteColor()
        subStyle.linesNumber = 1
        subStyle.offsset = 150
        
        
        var listPages: [ICETutorialPage] = [layer1, layer2, layer3, layer4, layer5]
        
        var controller: ICETutorialController = ICETutorialController(pages: listPages)
        controller.commonPageTitleStyle = titleStyle
        controller.commonPageSubTitleStyle = subStyle
        controller.startScrolling()
        

        
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
            let loginVC = controller
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



