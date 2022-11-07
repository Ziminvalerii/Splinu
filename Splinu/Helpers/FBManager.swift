//
//  FBManager.swift
//  MayanDiamonds
//
//  Created by 1 on 29.11.2021.
//

import FBSDKCoreKit
import AVFoundation

struct FBIds: Decodable {
    let appId: String
    let clientToken: String
}

class FBManager {
    
    static let shared = FBManager()
    
    func setUpFB(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.getStatus { fbIds in
            if let fbIds = fbIds {
                print("got appId and clientToken:", fbIds.appId, fbIds.clientToken)
                Settings.shared.appID = fbIds.appId
                Settings.shared.clientToken = fbIds.clientToken
//                Settings.isAdvertiserIDCollectionEnabled = true
                Settings.shared.appURLSchemeSuffix = "fb\(fbIds.appId)"
                Settings.shared.isAutoLogAppEventsEnabled = true
                ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
                self.fetchDeep()
            } else {
                print("no appId :(")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    private func fetchDeep() {
        AppLinkUtility.fetchDeferredAppLink { (url, error) in
            if let url = url {
                let str = url.absoluteString
                EventsManager.gotDeep(str: str)
            }
        }
    }
    
    private func getStatus(completion: @escaping (FBIds?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "apps-gateway-qusw2.ondigitalocean.app"
        urlComponents.path = "/variables"
        urlComponents.queryItems = [
            URLQueryItem(name: "app", value: Consts.appID),
        ]
        guard let url = urlComponents.url else {
            completion(nil)
            return
        }
        
        print("requesting: \(url.absoluteString)")
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            do {
                let fbIds = try JSONDecoder().decode(FBIds.self, from: data)
                print(fbIds)
                DispatchQueue.main.async { completion(fbIds) }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError.localizedDescription)
                DispatchQueue.main.async { completion(nil) }
            }
        }
        dataTask.resume()
    }
    
}

