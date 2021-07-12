//
//  AppDelegate.swift
//  KTymKMojiTLine
//
//  Created by JOJO on 2021/7/8.
//
// com.emoinji.IgtextC

import UIKit
import Adjust
import SwiftyStoreKit
import FirebaseMessaging
import FirebaseInstanceID
import AdSupport
import AppTrackingTransparency
import AppsFlyerLib


// he /*
// com.emoinji.IgtextC
enum AdjustKey: String {
    case AdjustKeyAppToken = "w8hafk8lp98g"
    case AdjustKeyAppLaunch = "o9lpuv"
    case AdjustKeyAppCoinsBuy = "m5g62a"
    case AdjustUserDefaultTrackerName = "udTrackerName"
    case AdjustNotiTrackerName = "notiNotiTrackerName"
}

extension AppDelegate: AdjustDelegate {
    func adjustAttributionChanged(_ attribution: ADJAttribution?) {
        UserDefaults.standard.setValue(attribution?.trackerName, forKey: AdjustKey.AdjustUserDefaultTrackerName.rawValue)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AdjustKey.AdjustNotiTrackerName.rawValue), object: nil)
      
        
    }
    func initAdjust() {
        // he /*
        let ajconfig = ADJConfig(appToken: AdjustKey.AdjustKeyAppToken.rawValue, environment: ADJEnvironmentProduction)
        ajconfig?.delegate = self
        Adjust.appDidLaunch(ajconfig)
        Adjust.trackEvent(ADJEvent(eventToken: AdjustKey.AdjustKeyAppLaunch.rawValue))
        
        // he */
    }
    
}

// 核里面 AdjustConfig.json 也要填
// 测试 进 ID com.testbase.www
// he */


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var deviceTokenStr: String = ""
    
    var window: UIWindow?
    var mainVC: KTyMainViewC = KTyMainViewC()
    
    
    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }

    func setupIAP() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        APLoginMana.fireAppInit()
        setupFirebaseMessage()
        setupIAP()
        initMainVC()
        
        trackeringAuthor()
        // he /*
        initCore()
        // he */
        
        registerNotifications(application)
        
        AppFlyerEventManager.default.setupAppsFlyer()
        
        
        
        return true
    }
    
    
    func initCore() {
        // he /*
       
//        com.emoinji.IgtextC
        
        NotificationCenter.default.post(name: .water,
                                        object: [
                                            HightLigtingHelper.default.debugBundleIdentifier = "com.emoinji.IgtextC",
                                            HightLigtingHelper.default.setProductUrl(string: "https://storyedit.icu/new/")])
        // he */
    }
    
    func trackeringAuthor() {
       
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: {[weak self] status in
                guard let `self` = self else {return}
                self.initAdjust()
            })
        }
    }
    
 
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
         
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
         
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        APLoginMana.receivesAuthenticationProcess(url: url, options: options)
        AppFlyerEventManager.default.flyerLibHandleOpen(url: url, options: options)
        
        return true
    }
    
    func setupFirebaseMessage() {
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = false
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
          }
        }
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
//            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }
    }
    
    // Appsflyer
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Start the SDK (start the IDFA timeout set above, for iOS 14 or later)
//        AppFlyerEventManager.default.flyerLibStart()
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppFlyerEventManager.default.flyerLibContinue(userActivity: userActivity)
        
        return true
    }
    
    // Open Deeplinks
    // Open URI-scheme for iOS 9 and above
    
    
    // Report Push Notification attribution data for re-engagements
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppFlyerEventManager.default.flyerLibHandlePushNotification(userInfo: userInfo)
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let body = notification.request.content.body
        notification.request.content.userInfo
        print(body)
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("222222")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    
}




extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("Firebase registration token: \(fcmToken)")
        if let fcmToken_m = fcmToken {
            let dataDict:[String: String] = ["token": fcmToken_m]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        AppDelegate.deviceTokenStr = deviceTokenString(deviceToken: deviceToken)
        
    }
    
    func deviceTokenString(deviceToken: Data) -> String {
        var deviceTokenString = String()
        let bytes = [UInt8](deviceToken)
        for item in bytes {
            deviceTokenString += String(format:"%02x", item&0x000000FF)
        }
        return deviceTokenString
    }
}

extension AppDelegate {
    // 注册远程推送通知
    func registerNotifications(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                    if (result) {
                        if !(error != nil) {
                            // 注册成功
                            DispatchQueue.main.async {
                                application.registerForRemoteNotifications()
                            }
                        }
                    } else {
                        //用户不允许推送
                    }
                }
            } else if (setting.authorizationStatus == .denied){
                // 申请用户权限被拒
            } else if (setting.authorizationStatus == .authorized){
                // 用户已授权（再次获取dt）
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                // 未知错误
            }
        }
    }
}


class AppFlyerEventManager: NSObject, AppsFlyerLibDelegate {
    static let `default` = AppFlyerEventManager()
    var appsFlyerDevKey = "2nhkNASc2eUJM2U3WAvYHS"
    var appleAppID = "1575480067"
    
    func setupAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = appleAppID
        AppsFlyerLib.shared().delegate = self
        /* Set isDebug to true to see AppsFlyer debug logs */
        if UIApplication.shared.inferredEnvironment == .debug {
            AppsFlyerLib.shared().isDebug = true
        }
        
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
       
    }
    
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
        
    }
    
    
    func flyerLibContinue(userActivity: NSUserActivity) {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
    }
    
    func flyerLibHandleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey : Any]? = [:]) {
        AppsFlyerLib.shared().handleOpen(url, options: options)
    }
    
    func flyerLibHandlePushNotification(userInfo: [AnyHashable : Any]) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
   // AppsFlyerLibDelegate --
   // Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in installData {
            print(key, ":", value)
        }
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = installData["media_source"],
                   let campaign = installData["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = installData["is_first_launch"] as? Bool,
               is_first_launch {
                print("First Launch")
            } else {
                print("Not First Launch")
            }
        }
    }
    func onConversionDataFail(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]!) {
        if let data = attributionData{
            print("\(data)")
        }
    }
    func onAppOpenAttributionFailure(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }
   //-- AppsFlyerLibDelegate ^
    
    
    
    // event log
    // 成功购买
    func event_PurchaseSuccessAll(symbolType: String, needMoney: Float, iapId: String) {
        
        AppsFlyerLib.shared().logEvent("pi_purchase",
                                       withValues: [
                                        AFEventParamContent  : symbolType,
                                        AFEventParamRevenue  : needMoney,
                                        AFEventParamContentId: iapId])
    }
    
    func event_LaunchApp() {
        AppsFlyerLib.shared().logEvent("pi_launch", withValues: nil)
    }
    
    func event_login_button_1stclick() {
        AppsFlyerLib.shared().logEvent("login_button_1stclick", withValues: nil)
    }
    func event_login_button_click_total() {
        AppsFlyerLib.shared().logEvent("login_button_click_total", withValues: nil)
    }
    
}
