import UIKit
import LNRSimpleNotifications

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
    configNotification()
    return true
  }

  func configNotification() {
    LNRSimpleNotifications.sharedNotificationManager.notificationsPosition = LNRNotificationPosition.Top
    LNRSimpleNotifications.sharedNotificationManager.notificationsBackgroundColor = UIColor.whiteColor()
    LNRSimpleNotifications.sharedNotificationManager.notificationsTitleTextColor = UIColor.blackColor()
    LNRSimpleNotifications.sharedNotificationManager.notificationsBodyTextColor = UIColor.darkGrayColor()
    LNRSimpleNotifications.sharedNotificationManager.notificationsSeperatorColor = UIColor.grayColor()
  }

}

