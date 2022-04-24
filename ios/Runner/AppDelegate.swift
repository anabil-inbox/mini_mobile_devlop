import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          }// AIzaSyAuXMe85EcvsnWeFEsdF-nB-2hLwXKXjOs
     GMSServices.provideAPIKey("AIzaSyAuXMe85EcvsnWeFEsdF-nB-2hLwXKXjOs")//AIzaSyDOY6CHfRJCGabVn8nRe_wuQe99keYu230 mohamed key
    GMSServices.setMetalRendererEnabled(true)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
