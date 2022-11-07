//
//  EventsManager.swift
//  GoldDiggerRush
//
//  Created by toha on 03.06.2021.
//

import UIKit
import FBSDKCoreKit
import Firebase
import AVFoundation

struct EventsManager {
    
    static func handlePushNotification(_ userInfo: [AnyHashable : Any]) {
        if let event = userInfo["event"] as? String {
            switch event {
            case "reg", "registration":
                EventsManager.sendReg()
            case "dep":
                EventsManager.sendDep()
            default:
                print("Unknown event")
            }
        } else {
            print("Notification badly formatted", userInfo)
        }
    }
    
    static func sendReg() {
        AppEvents.shared.logEvent(AppEvents.Name.completedRegistration)
        //AppsFlyerLib.shared().logEvent("registration", withValues: [:])
    }
    
    static func sendDep() {
        AppEvents.shared.logPurchase(amount: 1, currency: "USD")
        //AppsFlyerLib.shared().logEvent("dep", withValues: [:])
    }
    
    static func sendInstall() {
        AppEvents.shared.activateApp()
    }
    
    static func trigerAll() {
        EventsManager.sendDep()
        EventsManager.sendReg()
        EventsManager.sendInstall()
    }
    
    static func gotDeep(str: String) {
        let key = "didSendDeep"
        let didSendDeep = UserDefaults.standard.bool(forKey: key)
        if !didSendDeep {
            //AppsFlyerLib.shared().logEvent(str, withValues: [:])
            Analytics.setUserProperty("str", forName: "deep")
            UserDefaults.standard.set(true, forKey: key)
        }
    }
}

extension UIViewController {
    func makeEventsSandable() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(sendEvents))
        gesture.minimumPressDuration = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc func sendEvents(gestureRecognizer:UIGestureRecognizer) {
        if gestureRecognizer.state == .began {
            print("long began")
            EventsManager.trigerAll()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
}
