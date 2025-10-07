import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDGoDnas1rIwmbH_N9-_2xgni0crzZcS2E")

    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyCOQO2bbnMQgcBUUhlSF461cOcXjZu7mic")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
