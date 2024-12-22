import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let dartDefinesString = Bundle.main.infoDictionary!["DartDefines"] as! String
    var dartDefines = [String:String]()
    for definedValue in dartDefinesString.components(separatedBy: ",") {
      let decoded = String(data: Data(base64Encoded: definedValue)!, encoding: .utf8)!
      let values = decoded.components(separatedBy: "=")
      dartDefines[values[0]] = values[1]
    }
    GMSServices.provideAPIKey(dartDefines["GOOGLEMAP_IOS_KEY"]!)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
