//
//  AppDelegate.swift
//  Gradle-iOS
//
//  Created by Pedro Paulo Amorim on 20/12/15.
//  Copyright © 2015 ppamorim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.window = UIWindow(frame: CGRectMake(0, 0,
      CGRectGetWidth(UIScreen.mainScreen().bounds),
      CGRectGetHeight(UIScreen.mainScreen().bounds)))
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.rootViewController = MainViewController()
    self.window!.makeKeyAndVisible()
    return true
  }


}

