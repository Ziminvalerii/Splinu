//
//  IDFAManager.swift
//  LevelUpGames
//
//  Created by 1 on 01.12.2021.
//

import FBSDKCoreKit
import AppTrackingTransparency

struct IDFAManager {
    
    static let shared = IDFAManager()
    
    func request() {
        DispatchQueue.main.async {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .notDetermined:
                        print("Not determined")
                    case .restricted:
                        print("restricted")
                    case .denied:
                        print("denied")
                    case .authorized:
                        print("Authorized")
                        handleAuth()
                    @unknown default:
                        break
                    }
                }
            } else {
                print("ios less then 14.0")
            }
        }
    }
    
    private func handleAuth() {
        let key = "didCheck"
        let didCheck = UserDefaults.standard.bool(forKey: key)
        if !didCheck {
            Settings.shared.isAdvertiserIDCollectionEnabled = true
//            Checker().getTrackUrl { _ in
//                print("id sent")
//            }
            UserDefaults.standard.set(true, forKey: key)
        }
    }
}
