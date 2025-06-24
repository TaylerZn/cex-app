import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging
import TGPassportKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      FirebaseApp.configure()
  if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self
    }
    GeneratedPluginRegistrant.register(with: self)
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController


      let methodchannel : FlutterMethodChannel = FlutterMethodChannel(name: "tg_login", binaryMessenger: controller.binaryMessenger)
      methodchannel.setMethodCallHandler { method, result in
        
          self.tgLogin()
      }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        TGPAppDelegate.shared().application(app, open: url)
    }
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        TGPAppDelegate.shared().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func generateNonce() -> String {
        return UUID().uuidString
    }
    func tgLogin(){
        //let botId: Int32 = 7532735747
        // let nonce = generateNonce()
        
        // let botConfig = TGPBotConfig(botId: 7532735747, publicKey: "7532735747:AAEFmmUZznjWx6fkbgKZiD5Ihdqf7bEttag")
        // let req : TGPRequest = TGPRequest.init(botConfig: botConfig)
        // req.perform(with: TGPScope(jsonString: "{\"data\":[\"id_document\",\"address_document\",\"phone_number\"],\"v\":1}"), nonce:nonce) { req, err in
        //     print("🔥🔥🔥🔥🔥\(req)\(err)")
        // }
        
    }
    
   
}
