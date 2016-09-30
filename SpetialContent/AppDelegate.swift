//
//  AppDelegate.swift
//  SpetialContent
//
//  Created by Andrey Volobuev on 16/05/16.
//  Copyright © 2016 Andrey Volobuev. All rights reserved.
//

/*
 
 Solution takes a chat message string and returns a JSON string containing information about its contents. Special content to look for includes:
 
 1. @mentions - A way to mention a user. Always starts with an '@' and ends when hitting a non-word character.
 
 2. Emoticons - 'custom' emoticons which are alphanumeric strings, no longer than 15 characters, contained in parenthesis.
 
 3. Links - Any URLs contained in the message, along with the page's title.
 
 For example, calling your function with the following inputs should result in the corresponding return values.
 
 Input: "@chris you around?"
 Return (string):
 { "mentions": [ "chris" ] }
 
 Input: "Good morning! (megusta) (coffee)"
 Return (string):
 { "emoticons": [ "megusta", "coffee" ] }
 
 Input: "Olympics are starting soon; http://www.nbcolympics.com"
 Return (string):
 { "links": [
        { "url": "http://www.nbcolympics.com", "title": "NBC Olympics | 2014 NBC Olympics in Sochi Russia" }
    ]
 }
 
 Input: "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
 Return (string):
 { "mentions": [
        "bob",
        "john"
    ],
 "emoticons": [
        "success"
    ],
 "links": [
        { "url": "https://twitter.com/jdorfman/status/430511497475670016", "title": "Twitter / jdorfman: nice @littlebigdetail from ..." }
    ]
 }
 
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
